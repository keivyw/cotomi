class PatientViewModel: ObservableObject {
    @Published var patients: [Patient] = []

    func fetchPatients() {
        guard let url = URL(string: "https://example.com/api/patients") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedPatients = try JSONDecoder().decode([Patient].self, from: data)
                    DispatchQueue.main.async {
                        self.patients = decodedPatients
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
}
