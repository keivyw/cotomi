import Foundation
import Combine

class PatientDetailViewModel: ObservableObject {
    @Published var detailData: PatientDetailData?
    private var cancellables = Set<AnyCancellable>()

    init(patientId: String) {
        fetchDetailData(patientId: patientId)
    }

    func fetchDetailData(patientId: String) {
        guard let url = URL(string: "https://your-api-endpoint.com/patients/\(patientId)/details") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PatientDetailData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Failed to fetch data: \(error)")
                }
            }, receiveValue: { [weak self] detailData in
                self?.detailData = detailData
            })
            .store(in: &cancellables)
    }
}
