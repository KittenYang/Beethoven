import Foundation

public class JainsEstimator: EstimationAware {

  public func estimateLocation(transformResult: TransformResult, sampleRate: Float) -> Int {
    let buffer = transformResult.buffer

    guard let maxElement = buffer.maxElement(),
      maxIndex = buffer.indexOf(maxElement) else {
        return 0
    }

    let y2 = abs(buffer[maxIndex])
    let y1 = maxIndex == 0 ? y2 : abs(buffer[maxIndex - 1])
    let y3 = maxIndex == buffer.count - 1 ? y2 : abs(buffer[maxIndex + 1])
    let location: Int

    if y1 > y3 {
      let a = y2 / y1
      let d = a / (1 + a)
      location = maxIndex - 1 + Int(round(d))
    } else {
      let a = y3 / y2
      let d = a / (1 + a)
      location = maxIndex + Int(round(d))
    }

    return location >= 0 && location < buffer.count
      ? location
      : maxIndex
  }
}
