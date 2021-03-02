public protocol LocationEstimator: Estimator {
  func estimateLocation(buffer: Buffer) throws -> Int
}

// MARK: - Default implementation

public extension LocationEstimator {
  var transformer: Transformer {
    return FFTTransformer()
  }

  func estimateFrequency(sampleRate: Float, buffer: Buffer) throws -> Float {
    let location = try estimateLocation(buffer: buffer)
    return estimateFrequency(sampleRate: sampleRate, location: location, bufferCount: buffer.count)
  }
}
