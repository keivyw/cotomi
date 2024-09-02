import SwiftUI

struct PatientDetailView: View {
    let detailData: PatientDetailData
    
    var body: some View {
        ScrollView {
            ScrollView(.horizontal) {
                VStack(alignment: .leading) {
                    Text("Aさん")
                        .font(.largeTitle)
                        .bold()
                        .padding([.top, .bottom], 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 項目のヘッダー
                    HStack {
                        Text("日付")
                            .bold()
                            .frame(width: 100, alignment: .leading)
                        Text("頭痛")
                            .bold()
                            .frame(width: 100, alignment: .center)
                        Text("薬")
                            .bold()
                            .frame(width: 100, alignment: .center)
                        Text("食事")
                            .bold()
                            .frame(width: 100, alignment: .center)
                        Text("生理")
                            .bold()
                            .frame(width: 100, alignment: .center)
                        Text("備考")
                            .bold()
                            .frame(width: 100, alignment: .center)
                    }
                    .padding(.bottom, 8)
                    
                    // データの行
                    ForEach(detailData.dailyData) { data in
                        HStack {
                            Text(formatDate(data.date))
                                .frame(width: 100, alignment: .leading)
                            Text("\(data.headache)")
                                .frame(width: 100, alignment: .center)
                            Text(data.medication ? "✓" : "✗")
                                .frame(width: 100, alignment: .center)
                            Text(data.diet)
                                .frame(width: 100, alignment: .center)
                            Text(data.menstruation ? "✓" : "✗")
                                .frame(width: 100, alignment: .center)
                            Text(data.statusMemo)
                                .frame(width: 100, alignment: .center)
                        }
                        .padding(.vertical, 4)
                        Divider() // 各行の間に区切り線を追加
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle(Text(detailData.patient.name), displayMode: .inline) // ナビゲーションバーの中央に患者名
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

struct PatientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let mockPatient = Patient(name: "Aさん", status: "良い")
        let mockData = PatientDetailData(patient: mockPatient)
        PatientDetailView(detailData: mockData)
    }
}
