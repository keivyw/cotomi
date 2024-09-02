import SwiftUI

struct Patient: Identifiable {
    let id = UUID()
    let name: String
    let status: String
}


struct ContentView: View {
    // @StateObject private var viewModel = PatientViewModel()
    
    let patients = [
        Patient(name: "Aさん", status: "良い"),
        Patient(name: "Bさん", status: "普通"),
        Patient(name: "Cさん", status: "悪い"),
        Patient(name: "Dさん", status: "良い"),
        Patient(name: "Eさん", status: "良い"),
    ]
    
    var body: some View {
        NavigationView {
            List(patients) { patient in
                HStack {
                    // 左側にアイコンを追加
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                    
                    // 名前とステータス
                    VStack(alignment: .leading) {
                        Text(patient.name)
                            .font(.headline)
                        Text(patient.status)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 8)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Patients")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
