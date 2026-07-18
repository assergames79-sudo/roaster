import Foundation

struct Roast: Identifiable {
    let id = UUID()
    let text: String
    let category: Category

    enum Category: String, CaseIterable {
        case savage = "Savage"
        case witty = "Witty"
        case brutal = "Brutal"
        case savageSays = "Savage Says"
        case classic = "Classic"

        var color: String {
            switch self {
            case .savage: return "red"
            case .witty: return "blue"
            case .brutal: return "orange"
            case .savageSays: return "purple"
            case .classic: return "green"
            }
        }
    }
}

extension Roast {
    static let allRoasts: [Roast] = [
        Roast(text: "I'm not saying you're stupid, but you have a strong case against yourself.", category: .savage),
        Roast(text: "You're the reason God created the middle finger.", category: .savage),
        Roast(text: "If you were any more inbred, you'd be a sandwich.", category: .brutal),
        Roast(text: "I'd agree with you, but then we'd both be wrong.", category: .witty),
        Roast(text: "You bring everyone a lot of joy... when you leave.", category: .savage),
        Roast(text: "You're not stupid. You just have bad luck when thinking.", category: .brutal),
        Roast(text: "I'm jealous of people who don't know you.", category: .savage),
        Roast(text: "You're like a cloud. When you disappear, it's a beautiful day.", category: .witty),
        Roast(text: "I'd explain it to you, but I left my English-to-Idiot dictionary at home.", category: .brutal),
        Roast(text: "You're proof that evolution can go in reverse.", category: .savage),
        Roast(text: "You're like a human version of a participation trophy.", category: .savageSays),
        Roast(text: "I'm not roasting you, I'm just stating facts with flavor.", category: .savageSays),
        Roast(text: "Somewhere out there, a tree is working hard to replace the oxygen you waste.", category: .classic),
        Roast(text: "You're the human equivalent of a typo.", category: .classic),
        Roast(text: "I'd say bless your heart, but you don't have one worth blessing.", category: .witty)
    ]
}
