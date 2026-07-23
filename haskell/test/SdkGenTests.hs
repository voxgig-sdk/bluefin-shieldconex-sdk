-- Generated model-driven entity + direct tests.
{-# LANGUAGE ScopedTypeVariables #-}

module SdkGenTests (genTests) where

import Control.Exception (SomeException, try)
import Data.IORef

import VoxgigStruct (Value (..), emptyMap, keysof, ismap, islist, isNoval, clone)
import SdkTypes
import SdkHelpers
import qualified SdkFeatures as F
import qualified SdkClient as C
import qualified TReadmeExamples
import Testutil
import TestJson (jsonRead)

-- Load an entity fixture (../.sdk/test/entity/<name>/<Name>TestData.json).
loadFixture :: String -> IO Value
loadFixture entName = do
  let lname = map toLowerCh entName
  raw <- readFile ("../.sdk/test/entity/" ++ lname ++ "/" ++ entName ++ "TestData.json")
  jsonRead raw
  where toLowerCh ch = if ch >= 'A' && ch <= 'Z' then toEnum (fromEnum ch + 32) else ch

-- The first new-ref data map for an entity (fixture.new.<entity>.<ref0>).
newRefData :: Value -> String -> IO Value
newRefData fixture entName = do
  newEnts <- getpathS fixture ("new." ++ entName)
  refs <- keysof newEnts
  case refs of
    [] -> emptyMap
    (r0 : _) -> do d <- getp newEnts r0; clone d

genTests :: Counters -> IO ()
genTests c = do
  TReadmeExamples.tests c
  detokenizeInstanceTest c
  detokenizeBasicTest c
  detokenizeDirectTest c
  detokenizeStreamTest c
  tokenizeInstanceTest c
  tokenizeBasicTest c
  tokenizeDirectTest c
  tokenizeStreamTest c
  tokenize_batchInstanceTest c
  tokenize_batchBasicTest c
  tokenize_batchDirectTest c
  tokenize_readInstanceTest c
  tokenize_readBasicTest c
  tokenize_readDirectTest c
  validateInstanceTest c
  validateBasicTest c
  validateDirectTest c

detokenizeInstanceTest :: Counters -> IO ()
detokenizeInstanceTest c = runTest c "detokenize.instance" $ do
  sdk <- C.testSdk0
  ent <- C.detokenize sdk VNoval
  pure (eName ent == "detokenize")

detokenizeBasicTest :: Counters -> IO ()
detokenizeBasicTest c = do
  fixture <- loadFixture "Detokenize"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "detokenize.list" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.detokenize sdk VNoval
    em1 <- emptyMap; em2 <- emptyMap
    lst <- eList ent em1 em2
    pure (islist lst)
  runTest c "detokenize.create" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.detokenize sdk VNoval
    d <- newRefData fixture "detokenize"
    ctrl <- emptyMap
    created <- eCreate ent d ctrl
    cid <- getp created "id"
    pure (ismap created && not (isNoval cid))

detokenizeDirectTest :: Counters -> IO ()
detokenizeDirectTest c = runTest c "detokenize.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/detokenize/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

detokenizeStreamTest :: Counters -> IO ()
detokenizeStreamTest c = do
  let mkSeed = do
        r1 <- jo [("id", VStr "S1"), ("name", VStr "a")]
        r2 <- jo [("id", VStr "S2"), ("name", VStr "b")]
        r3 <- jo [("id", VStr "S3"), ("name", VStr "c")]
        recs <- jo [("S1", r1), ("S2", r2), ("S3", r3)]
        jo [("detokenize", recs)]
      hasStreaming = do
        sdk0 <- C.testSdk0
        fs <- getp (clConfig sdk0) "feature"
        st <- getp fs "streaming"
        pure (not (isNoval st))
  runTest c "detokenize.stream" $ do
    seed <- mkSeed; opts <- jo [("entity", seed)]
    sdk <- C.testSdk opts VNoval
    ent <- C.detokenize sdk VNoval
    em1 <- emptyMap
    items <- eStream ent "list" em1 VNoval
    pure (length items == 3 && (case items of (x : _) -> ismap x; [] -> False))
  runTest c "detokenize.stream_signal" $ do
    seed <- mkSeed; opts <- jo [("entity", seed)]
    sdk <- C.testSdk opts VNoval
    ent <- C.detokenize sdk VNoval
    em1 <- emptyMap
    n <- newIORef (0 :: Int)
    let sig = vfunc0 (do modifyIORef n (+ 1); v <- readIORef n; pure (VBool (v >= 2)))
    co <- jo [("signal", sig)]
    items <- eStream ent "list" em1 co
    pure (length items == 1)
  runTest c "detokenize.stream_active" $ do
    hs <- hasStreaming
    if not hs then pure True else do
      seed <- mkSeed; opts <- jo [("entity", seed)]
      stg <- jo [("active", VBool True)]; strm <- jo [("streaming", stg)]; sopts <- jo [("feature", strm)]
      sdk <- C.testSdk opts sopts
      ent <- C.detokenize sdk VNoval
      em1 <- emptyMap
      items <- eStream ent "list" em1 VNoval
      pure (length items == 3)
  runTest c "detokenize.stream_chunk" $ do
    hs <- hasStreaming
    if not hs then pure True else do
      seed <- mkSeed; opts <- jo [("entity", seed)]
      stg <- jo [("active", VBool True), ("chunkSize", VNum 2)]; strm <- jo [("streaming", stg)]; sopts <- jo [("feature", strm)]
      sdk <- C.testSdk opts sopts
      ent <- C.detokenize sdk VNoval
      em1 <- emptyMap
      batches <- eStream ent "list" em1 VNoval
      pure (length batches == 2)

tokenizeInstanceTest :: Counters -> IO ()
tokenizeInstanceTest c = runTest c "tokenize.instance" $ do
  sdk <- C.testSdk0
  ent <- C.tokenize sdk VNoval
  pure (eName ent == "tokenize")

tokenizeBasicTest :: Counters -> IO ()
tokenizeBasicTest c = do
  fixture <- loadFixture "Tokenize"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "tokenize.list" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.tokenize sdk VNoval
    em1 <- emptyMap; em2 <- emptyMap
    lst <- eList ent em1 em2
    pure (islist lst)
  runTest c "tokenize.create" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.tokenize sdk VNoval
    d <- newRefData fixture "tokenize"
    ctrl <- emptyMap
    created <- eCreate ent d ctrl
    cid <- getp created "id"
    pure (ismap created && not (isNoval cid))

tokenizeDirectTest :: Counters -> IO ()
tokenizeDirectTest c = runTest c "tokenize.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/tokenize/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

tokenizeStreamTest :: Counters -> IO ()
tokenizeStreamTest c = do
  let mkSeed = do
        r1 <- jo [("id", VStr "S1"), ("name", VStr "a")]
        r2 <- jo [("id", VStr "S2"), ("name", VStr "b")]
        r3 <- jo [("id", VStr "S3"), ("name", VStr "c")]
        recs <- jo [("S1", r1), ("S2", r2), ("S3", r3)]
        jo [("tokenize", recs)]
      hasStreaming = do
        sdk0 <- C.testSdk0
        fs <- getp (clConfig sdk0) "feature"
        st <- getp fs "streaming"
        pure (not (isNoval st))
  runTest c "tokenize.stream" $ do
    seed <- mkSeed; opts <- jo [("entity", seed)]
    sdk <- C.testSdk opts VNoval
    ent <- C.tokenize sdk VNoval
    em1 <- emptyMap
    items <- eStream ent "list" em1 VNoval
    pure (length items == 3 && (case items of (x : _) -> ismap x; [] -> False))
  runTest c "tokenize.stream_signal" $ do
    seed <- mkSeed; opts <- jo [("entity", seed)]
    sdk <- C.testSdk opts VNoval
    ent <- C.tokenize sdk VNoval
    em1 <- emptyMap
    n <- newIORef (0 :: Int)
    let sig = vfunc0 (do modifyIORef n (+ 1); v <- readIORef n; pure (VBool (v >= 2)))
    co <- jo [("signal", sig)]
    items <- eStream ent "list" em1 co
    pure (length items == 1)
  runTest c "tokenize.stream_active" $ do
    hs <- hasStreaming
    if not hs then pure True else do
      seed <- mkSeed; opts <- jo [("entity", seed)]
      stg <- jo [("active", VBool True)]; strm <- jo [("streaming", stg)]; sopts <- jo [("feature", strm)]
      sdk <- C.testSdk opts sopts
      ent <- C.tokenize sdk VNoval
      em1 <- emptyMap
      items <- eStream ent "list" em1 VNoval
      pure (length items == 3)
  runTest c "tokenize.stream_chunk" $ do
    hs <- hasStreaming
    if not hs then pure True else do
      seed <- mkSeed; opts <- jo [("entity", seed)]
      stg <- jo [("active", VBool True), ("chunkSize", VNum 2)]; strm <- jo [("streaming", stg)]; sopts <- jo [("feature", strm)]
      sdk <- C.testSdk opts sopts
      ent <- C.tokenize sdk VNoval
      em1 <- emptyMap
      batches <- eStream ent "list" em1 VNoval
      pure (length batches == 2)

tokenize_batchInstanceTest :: Counters -> IO ()
tokenize_batchInstanceTest c = runTest c "tokenize_batch.instance" $ do
  sdk <- C.testSdk0
  ent <- C.tokenize_batch sdk VNoval
  pure (eName ent == "tokenize_batch")

tokenize_batchBasicTest :: Counters -> IO ()
tokenize_batchBasicTest c = do
  fixture <- loadFixture "TokenizeBatch"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "tokenize_batch.create" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.tokenize_batch sdk VNoval
    d <- newRefData fixture "tokenize_batch"
    ctrl <- emptyMap
    created <- eCreate ent d ctrl
    cid <- getp created "id"
    pure (ismap created && not (isNoval cid))

tokenize_batchDirectTest :: Counters -> IO ()
tokenize_batchDirectTest c = runTest c "tokenize_batch.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/tokenize_batch/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

tokenize_readInstanceTest :: Counters -> IO ()
tokenize_readInstanceTest c = runTest c "tokenize_read.instance" $ do
  sdk <- C.testSdk0
  ent <- C.tokenize_read sdk VNoval
  pure (eName ent == "tokenize_read")

tokenize_readBasicTest :: Counters -> IO ()
tokenize_readBasicTest c = do
  fixture <- loadFixture "TokenizeRead"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "tokenize_read.create" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.tokenize_read sdk VNoval
    d <- newRefData fixture "tokenize_read"
    ctrl <- emptyMap
    created <- eCreate ent d ctrl
    cid <- getp created "id"
    pure (ismap created && not (isNoval cid))

tokenize_readDirectTest :: Counters -> IO ()
tokenize_readDirectTest c = runTest c "tokenize_read.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/tokenize_read/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

validateInstanceTest :: Counters -> IO ()
validateInstanceTest c = runTest c "validate.instance" $ do
  sdk <- C.testSdk0
  ent <- C.validate sdk VNoval
  pure (eName ent == "validate")

validateBasicTest :: Counters -> IO ()
validateBasicTest c = do
  fixture <- loadFixture "Validate"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "validate.create" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.validate sdk VNoval
    d <- newRefData fixture "validate"
    ctrl <- emptyMap
    created <- eCreate ent d ctrl
    cid <- getp created "id"
    pure (ismap created && not (isNoval cid))

validateDirectTest :: Counters -> IO ()
validateDirectTest c = runTest c "validate.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/validate/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)
