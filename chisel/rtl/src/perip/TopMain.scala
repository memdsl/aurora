import chisel3._
import circt.stage._

import ip.perip._

object TopMain extends App {
    def topUART = new UART()
    def topGPIO = new GPIO()
    def topHDMI = new HDMI()

    val genUART = Seq(chisel3.stage.ChiselGeneratorAnnotation(() => topUART));
    (new ChiselStage).execute(
        args,
        genUART :+ CIRCTTargetAnnotation(CIRCTTarget.Verilog))

    val genGPIO = Seq(chisel3.stage.ChiselGeneratorAnnotation(() => topGPIO));
    (new ChiselStage).execute(
        args,
        genGPIO :+ CIRCTTargetAnnotation(CIRCTTarget.Verilog))

    val genHDMI = Seq(chisel3.stage.ChiselGeneratorAnnotation(() => topHDMI));
    (new ChiselStage).execute(
        args,
        genHDMI :+ CIRCTTargetAnnotation(CIRCTTarget.Verilog))
}