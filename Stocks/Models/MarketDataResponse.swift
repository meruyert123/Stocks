import Foundation

struct MarketDataResponse: Codable {
    let open: [Double]
    let close: [Double]
    let high: [Double]
    let low: [Double]
    let status: String
    let timestamps: [TimeInterval]
    
    enum CodingKeys: String, CodingKey {
        case open = "o"
        case close = "c"
        case high = "h"
        case low = "l"
        case status = "s"
        case timestamps = "t"
    }
    
    var candleSticks: [CandleStick] {
        var result = [CandleStick]()
        
        for i in 0..<open.count {
            result.append(
                .init(open: open[i],
                      close: close[i],
                      high: high[i],
                      low: low[i],
                      date: Date(timeIntervalSince1970: timestamps[i]))
            )
        }
        
        let sortedData = result.sorted(by: { $0.date < $1.date })
        return sortedData
    }
}

struct CandleStick {
    let open: Double
    let close: Double
    let high: Double
    let low: Double
    let date: Date
}
