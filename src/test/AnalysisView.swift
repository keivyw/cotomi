import SwiftUI

struct AnalysisView: View {
    let patientDetailData: PatientDetailData
    
    var body: some View {
        VStack(alignment: .leading) {
            // 患者名を表示
            Text(patientDetailData.patient.name)
                .font(.largeTitle)
                .bold()
                .padding([.top, .bottom], 16)
                .frame(maxWidth: .infinity, alignment: .center)
            
            // 頭痛の平均値を表示するヒストグラム
            HistogramView(data: calculateAverageHeadacheByWeek())
                .padding(.horizontal)
            
            // 薬を飲んだ日数を表示
            Text("薬を飲んだ日数: \(calculateMedicationDaysByWeek().first!)/\(calculateMedicationDaysByWeek().max() ?? 7)")
                .padding(.top, 8)
                .padding(.horizontal)
            
            // 生理があった日数を表示
            Text("生理があった日数: \(calculateMenstruationDaysByWeek().first!)/\(calculateMenstruationDaysByWeek().max() ?? 7)")
                .padding(.top, 8)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
    
    // 頭痛の平均値を週ごとに計算する
    private func calculateAverageHeadacheByWeek() -> [Double] {
        var weeklyAverages: [Double] = []
        let calendar = Calendar.current
        
        for weekOffset in 0..<4 {
            let startOfWeek = calendar.date(byAdding: .weekOfYear, value: -weekOffset, to: Date())!
            let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
            
            let weekData = patientDetailData.dailyData.filter { calendar.isDate($0.date, inSameDayAs: startOfWeek) || calendar.isDate($0.date, inSameDayAs: endOfWeek) }
            
            let average = weekData.map { Double($0.headache) }.reduce(0, +) / Double(weekData.count)
            weeklyAverages.append(average)
        }
        
        return weeklyAverages.reversed() // 右側が最新週になるように逆順にする
    }
    
    // 薬を飲んだ日数を週ごとに計算する
    private func calculateMedicationDaysByWeek() -> [Int] {
        var weeklyCounts: [Int] = []
        let calendar = Calendar.current
        
        for weekOffset in 0..<4 {
            let startOfWeek = calendar.date(byAdding: .weekOfYear, value: -weekOffset, to: Date())!
            let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
            
            let weekData = patientDetailData.dailyData.filter { calendar.isDate($0.date, inSameDayAs: startOfWeek) || calendar.isDate($0.date, inSameDayAs: endOfWeek) }
            
            let count = weekData.filter { $0.medication }.count
            weeklyCounts.append(count)
        }
        
        return weeklyCounts.reversed()
    }
    
    // 生理があった日数を週ごとに計算する
    private func calculateMenstruationDaysByWeek() -> [Int] {
        var weeklyCounts: [Int] = []
        let calendar = Calendar.current
        
        for weekOffset in 0..<4 {
            let startOfWeek = calendar.date(byAdding: .weekOfYear, value: -weekOffset, to: Date())!
            let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
            
            let weekData = patientDetailData.dailyData.filter { calendar.isDate($0.date, inSameDayAs: startOfWeek) || calendar.isDate($0.date, inSameDayAs: endOfWeek) }
            
            let count = weekData.filter { $0.menstruation }.count
            weeklyCounts.append(count)
        }
        
        return weeklyCounts.reversed()
    }
}

struct HistogramView: View {
    var data: [Double]
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            ForEach(data.indices, id: \.self) { index in
                VStack {
                    Text(String(format: "%.1f", data[index]))
                        .font(.caption)
                        .padding(.bottom, 4)
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 30, height: CGFloat(data[index]) * 20)
                    Text(weekLabel(for: index))
                        .font(.caption)
                        .padding(.top, 4)
                }
            }
        }
    }
    
    private func weekLabel(for index: Int) -> String {
        switch index {
        case 0: return "4週前"
        case 1: return "3週前"
        case 2: return "先週"
        case 3: return "今週"
        default: return ""
        }
    }
}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        let mockPatient = Patient(name: "Aさん", status: "良い")
        let mockData = PatientDetailData(patient: mockPatient)
        AnalysisView(patientDetailData: mockData)
    }
}

