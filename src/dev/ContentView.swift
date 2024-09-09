// 患者一覧

import SwiftUI

struct Patient: Identifiable, Codable {
    let id: String
    let user_id: String
    let user_name: String
    let user_email: String
    let headache_intensity: Int
    let medicine_taken: Bool
    let medicine_effect: Bool
    let medicine_name: String
    let status: String
}

struct ContentView: View {
    @StateObject private var viewModel = PatientViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.patients) { patient in
                HStack {
                    VStack(alignment: .leading) {
                        Text(patient.user_name)
                            .font(.headline)
                        Text("頭痛の強さ: \(patient.headache_intensity)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("薬の服用: \(patient.medicine_taken)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("薬効: \(patient.medicine_effect)")
                            .font(.subheadline)
                            .foregroundColor(.gray)                                                     
                    }
                    .padding(.leading, 8)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Patients")
            .onAppear {
                viewModel.fetchPatients()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
