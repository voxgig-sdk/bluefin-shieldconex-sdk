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
             (let [res (e-detokenize/create ent (vs/jm "name" "smoke") nil)]
               (t/is-true (vs/ismap res) "create returns a record map")
               (t/is-true (some? (vs/getprop res "id")) "created record has an id"))
             (let [items (e-detokenize/list ent (vs/jm) nil)]
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
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
  (t/run-check rec "gen-exists-tokenize"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/tokenize sdk nil)) "tokenize accessor present"))))
  (t/run-check rec "gen-smoke-tokenize"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/tokenize sdk nil)]
             (let [res (e-tokenize/create ent (vs/jm "name" "smoke") nil)]
               (t/is-true (vs/ismap res) "create returns a record map")
               (t/is-true (some? (vs/getprop res "id")) "created record has an id"))
             (let [items (e-tokenize/list ent (vs/jm) nil)]
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
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
  (t/run-check rec "gen-exists-tokenize_batch"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/tokenize_batch sdk nil)) "tokenize_batch accessor present"))))
  (t/run-check rec "gen-smoke-tokenize_batch"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/tokenize_batch sdk nil)]
             (let [res (e-tokenize_batch/create ent (vs/jm "name" "smoke") nil)]
               (t/is-true (vs/ismap res) "create returns a record map")
               (t/is-true (some? (vs/getprop res "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-exists-tokenize_read"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/tokenize_read sdk nil)) "tokenize_read accessor present"))))
  (t/run-check rec "gen-smoke-tokenize_read"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/tokenize_read sdk nil)]
             (let [res (e-tokenize_read/create ent (vs/jm "name" "smoke") nil)]
               (t/is-true (vs/ismap res) "create returns a record map")
               (t/is-true (some? (vs/getprop res "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-exists-validate"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/validate sdk nil)) "validate accessor present"))))
  (t/run-check rec "gen-smoke-validate"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/validate sdk nil)]
             (let [res (e-validate/create ent (vs/jm "name" "smoke") nil)]
               (t/is-true (vs/ismap res) "create returns a record map")
               (t/is-true (some? (vs/getprop res "id")) "created record has an id"))
             )))
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
  (letfn [(clj-blocks [text]
            (let [fence (apply str (repeat 3 (char 96)))
                  parts (clojure.string/split text (re-pattern fence))]
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
            (let [blocks (clj-blocks (slurp path))]
              (doseq [b blocks]
                (binding [*read-eval* false]
                  (read-string (str "[\n" b "\n]"))))
              (t/is-true true (str label " clojure blocks parse cleanly"))))))))
  nil)
