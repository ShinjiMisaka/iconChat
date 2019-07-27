import UIKit
import Firebase

class RoomData: NSObject {
    var id: String?
    var users:[String?] = []
    var roomName:String?
    var number:Int?
    var comments:String?
    var displayName:String?
    var icon:URL?
    
    
    init(snapshot: DataSnapshot, myId: String) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        
        self.users = [valueDictionary["users"] as? String]
        
        self.roomName = valueDictionary["roomName"] as? String
        
        self.number = valueDictionary["number"] as? Int ?? nil
        
        self.comments = valueDictionary["comments"] as? String
        
        self.displayName = valueDictionary["displayName"] as? String
        
        self.icon = valueDictionary["icon"] as? URL
    }
}
