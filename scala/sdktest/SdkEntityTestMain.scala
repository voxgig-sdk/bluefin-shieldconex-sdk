// Aggregating entry point for the generated per-entity SDK tests. Drives
// every <Entity>EntityTest / <Entity>DirectTest object through one shared
// SdkTestReport and exits non-zero on any failure.
// Run: scala-cli run . --main-class SdkEntityTestMain

object SdkEntityTestMain {

  def main(args: Array[String]): Unit = {
    val rep = new SdkTestReport()

    DetokenizeEntityTest.run(rep)
    DetokenizeDirectTest.run(rep)
    TokenizeEntityTest.run(rep)
    TokenizeDirectTest.run(rep)
    TokenizeBatchEntityTest.run(rep)
    TokenizeReadEntityTest.run(rep)
    ValidateEntityTest.run(rep)

    ReadmeExamplesTest.run(rep)

    rep.finish("ENTITY")
  }
}
