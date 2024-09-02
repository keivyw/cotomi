import Foundation

struct DailyData: Identifiable {
    let id = UUID()
    let date: Date
    let headache: Int // 0〜5
    let medication: Bool // マルかバツ
    let diet: String // 食事内容
    let menstruation: Bool // マルかバツ
    let statusMemo: String
}

struct PatientDetailData {
    let patient: Patient
    let dailyData: [DailyData]
    
    init(patient: Patient) {
        self.patient = patient
        self.dailyData = PatientDetailData.generateMockData()
    }
    
    private static func generateMockData() -> [DailyData] {
        let today = Date()
        var data: [DailyData] = []
        
        for i in 0..<30 {
            if let date = Calendar.current.date(byAdding: .day, value: -i, to: today) {
                let dailyData = DailyData(
                    date: date,
                    headache: Int.random(in: 0...5),
                    medication: Bool.random(),
                    diet: ["Pasta", "Salad", "Pizza", "Sushi", "Bread"].randomElement() ?? "Unknown",
                    menstruation: Bool.random(),
                    statusMemo: "気圧低い"
                    
                )
                data.append(dailyData)
            }
        }
        
        return data
    }
}


