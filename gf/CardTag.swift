import Foundation

public enum CardTag: String {
    // MARK: Visitor subtags
    case Ship = "\u{1F47D}"
    case Probe = "\u{1F4E1}"
    case Entity = "\u{1F47E}"
    case Natual = "\u{1F320}"
    
    // MARK: Location subtags
    case A_ClassSystem = "A-\u{2600}\u{FE0F}"
    case B_ClassSystem = "B-\u{2600}\u{FE0F}"
    case C_ClassSystem = "C-\u{2600}\u{FE0F}"
    case D_ClassSystem = "D-\u{2600}\u{FE0F}"
    case E_ClassSystem = "E-\u{2600}\u{FE0F}"
    case F_ClassSystem = "F-\u{2600}\u{FE0F}"
    case G_ClassSystem = "G-\u{2600}\u{FE0F}"
    case H_ClassSystem = "H-\u{2600}\u{FE0F}"
    case I_ClassSystem = "I-\u{2600}\u{FE0F}"
    case EmptySystem = "\u{1F30C}"
    case AntimatterField = "AntimatterField"
    case Badlands = "Badlands"
    case BlackHole = "Blackhole"
    case Nebulae = "Nebulae"
    case Nova = "Nova"
    case NullSpace = "Null Space"
    case ParticleFountain = "Particle Fountain"
    case Quasar = "Quasar"
    case SpacialRift = "Spacial Rift"
    case TemporalFold = "Temporal Fold"
    case Wormhole = "Wormhole"
    
    
//    public static func cardTagFromName(name:String) ->CardTag? {
//        if (CardTag.Ship as String) == name {
//            return .Ship
//        }
//        return .Ship
//    }
}