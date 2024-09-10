# 生成AIコンテスト

### ファイル構成
<pre>
.
├── README.md
├── dev
│   ├── AnalysisView.swift
│   ├── ContentView.swift
│   ├── MyApp.swift
│   ├── PatientDetailView.swift
│   ├── PatientDetailViewModel.swift
│   └── PatientViewModel.swift
└── test
    ├── AnalysisView.swift
    ├── ContentView.swift
    ├── MyApp.swift
    ├── PatientDetailData.swift
    └── PatientDetailView.swift
</pre>


### ファイルの説明

#### 患者一覧（miroの左の画面）
- ContentView.swift レイアウト
- PatientViewModel.swift 患者一覧のAPI

APIは入力（トークン、医者ID）を完全に失念していた（すみません）ので、そこを追加してくれるとありがたいです。テーブルデータのAPIの方も同様です

#### テーブルデータ（miroの真ん中）
- PatientDetailView.swift レイアウト
- PatientDetailViewModel.swift テーブルデータのAPI

#### 分析画面（miroの右の画面）
- Analysis.swift レイアウト

APIはテーブルデータの方（PatientDetailViewModel.swift）を流用出来そうだなあと思ったところで止まってます


MyApp.swiftは何もいじってません






