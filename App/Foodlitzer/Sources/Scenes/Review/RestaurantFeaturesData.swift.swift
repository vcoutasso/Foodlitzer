import Foundation

struct FeatureDefinition {
    var question: String
    var symbol: String
    var rate: [String]
}

let lightEvatuation = FeatureDefinition(question: "How do you rate the lighting in the place?", symbol: "lightbulb",
                                        rate: ["Pouco iluminado", "Muito iluminado"])

let waitEvaluation = FeatureDefinition(question: "Como você avalia o tempo de esperar pela comida?", symbol: "clock",
                                       rate: ["Muito rápido", "Muito demorado"])

// let soundEvaluation: FeatureDefinition = FeatureDefinition(question: "Avaliação sonora:", symbol: "waveform")
