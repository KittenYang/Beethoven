import Foundation

public class QuinnsFirstEstimator: EstimationAware {

  public func estimateLocation(transformResult: TransformResult, sampleRate: Float) -> Int {
    let buffer = transformResult.buffer

    guard let maxElement = buffer.maxElement(),
      maxIndex = buffer.indexOf(maxElement) else {
        return 0
    }

    guard let complexBuffer = transformResult.complexBuffer else {
      return maxIndex
    }

    let realp = complexBuffer.realp
    let imagp = complexBuffer.imagp

    let prevIndex = maxIndex == 0 ? maxIndex : maxIndex - 1
    let nextIndex = maxIndex == buffer.count - 1 ? maxIndex : maxIndex + 1
    let divider = pow(realp[maxIndex], 2.0) + pow(imagp[maxIndex], 2.0)

    let ap = (realp[nextIndex] * realp[maxIndex] + imagp[nextIndex] * imagp[maxIndex]) / divider
    let dp = -ap  / (1.0 - ap)
    let am = (realp[prevIndex] * realp[maxIndex] + imagp[prevIndex] * imagp[maxIndex]) / divider
    let dm = am / (1.0 - am)
    let d = dp > 0 && dm > 0 ? dp : dm
    let location = maxIndex + Int(round(d))

    return location >= 0 && location < buffer.count
      ? location
      : maxIndex
  }
}






