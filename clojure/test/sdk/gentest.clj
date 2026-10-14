;; BluefinShieldconex SDK generated API tests.
(ns sdk.gentest
  (:require [sdk.api :as api]
            [sdk.config :as config]
            [sdk.testutil :as t]
            [clojure.string]
            [voxgig.struct :as vs]
            [sdk.entity.detokenize :as e-detokenize]
            [sdk.entity.tokenize :as e-tokenize]
            [sdk.entity.tokenize_batch :as e-tokenize_batch]
            [sdk.entity.tokenize_read :as e-tokenize_read]
            [sdk.entity.validate :as e-validate]))

(defn run [rec]
  (t/run-check rec "gen-exists-detokenize"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/detokenize sdk nil)) "detokenize accessor present"))))
  (t/run-check rec "gen-smoke-detokenize"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/detokenize sdk nil)]
             (let [res (e-detokenize/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             (let [items (e-detokenize/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-detokenize"
    (fn [] (let [seed (vs/jm "detokenize" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-detokenize/list (api/detokenize (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-detokenize"
    (fn [] (let [seed (vs/jm "detokenize" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-detokenize/stream (api/detokenize sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-detokenize/stream (api/detokenize sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-detokenize/stream (api/detokenize ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-detokenize/stream (api/detokenize csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-detokenize"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-detokenize/stream (api/detokenize (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-detokenize/stream (api/detokenize (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-detokenize/stream (api/detokenize denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-detokenize"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-detokenize/stream (api/detokenize (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-detokenize"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "detokenize hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/detokenize (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-detokenize/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-detokenize/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-detokenize"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-detokenize/list (api/detokenize client nil) (vs/jm "bfid" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-tokenize"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/tokenize sdk nil)) "tokenize accessor present"))))
  (t/run-check rec "gen-smoke-tokenize"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/tokenize sdk nil)]
             (let [res (e-tokenize/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             (let [items (e-tokenize/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-tokenize"
    (fn [] (let [seed (vs/jm "tokenize" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-tokenize/list (api/tokenize (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-tokenize"
    (fn [] (let [seed (vs/jm "tokenize" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-tokenize/stream (api/tokenize sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-tokenize/stream (api/tokenize sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-tokenize/stream (api/tokenize ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-tokenize/stream (api/tokenize csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-tokenize"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-tokenize/stream (api/tokenize (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-tokenize/stream (api/tokenize (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-tokenize/stream (api/tokenize denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-tokenize"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-tokenize/stream (api/tokenize (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-tokenize"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "tokenize hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/tokenize (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-tokenize/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-tokenize/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-tokenize"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-tokenize/list (api/tokenize client nil) (vs/jm "field_name" 1 "template_ref" "x") nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-tokenize_batch"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/tokenize_batch sdk nil)) "tokenize_batch accessor present"))))
  (t/run-check rec "gen-smoke-tokenize_batch"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/tokenize_batch sdk nil)]
             (let [res (e-tokenize_batch/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-validate-tokenize_batch"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-tokenize_batch/create (api/tokenize_batch client nil) (vs/jm "messageId" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-tokenize_read"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/tokenize_read sdk nil)) "tokenize_read accessor present"))))
  (t/run-check rec "gen-smoke-tokenize_read"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/tokenize_read sdk nil)]
             (let [res (e-tokenize_read/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-validate-tokenize_read"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-tokenize_read/create (api/tokenize_read client nil) (vs/jm "bfid" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-validate"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/validate sdk nil)) "validate accessor present"))))
  (t/run-check rec "gen-smoke-validate"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/validate sdk nil)]
             (let [res (e-validate/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-validate-validate"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-validate/create (api/validate client nil) (vs/jm "messageId" 1 "templateRef" "x") nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-prepare-detokenize"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/detokenize" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-detokenize"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/detokenize" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-tokenize"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/tokenize" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-tokenize"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/tokenize" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (letfn [(fence-pat [] (re-pattern (apply str (repeat 3 (char 96)))))
          (fence-count [text] (count (re-seq (fence-pat) text)))
          (clj-blocks [text]
            (let [parts (clojure.string/split text (fence-pat))]
              (->> parts
                   (map-indexed vector)
                   (filter (fn [[i _]] (odd? i)))
                   (map (fn [[_ seg]] seg))
                   (filter (fn [seg]
                             (= "clojure"
                                (clojure.string/trim (first (clojure.string/split-lines seg))))))
                   (map (fn [seg]
                          (clojure.string/join "\n"
                            (rest (clojure.string/split-lines seg))))))))]
    (doseq [[label path] [["root-README" "../README.md"]
                          ["README" "README.md"]
                          ["REFERENCE" "REFERENCE.md"]]]
      (t/run-check rec (str "gen-readme-examples-" label)
        (fn []
          (if-not (.exists (java.io.File. ^String path))
            (t/is-true true (str label " absent (skipped)"))
            (let [text (slurp path)]
              ;; A code fence opened but never closed leaves an ODD number of
              ;; fence markers; the split-on-fence then captures the trailing
              ;; prose (everything after the last opener) as if it were a
              ;; clojure block, which can parse cleanly and pass silently. Fail
              ;; on the malformed doc instead. (Count markers directly rather
              ;; than split parts: split drops trailing empty segments, so a
              ;; closing fence at EOF would be miscounted.)
              (t/is-true (even? (fence-count text))
                         (str label " code fences balanced (no unclosed fence)"))
              (let [blocks (clj-blocks text)]
                (doseq [b blocks]
                  (binding [*read-eval* false]
                    (read-string (str "[\n" b "\n]"))))
                (t/is-true true (str label " clojure blocks parse cleanly")))))))))
  nil)
