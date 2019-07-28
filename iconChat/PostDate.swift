import UIKit
import Firebase

class PostData: NSObject {
    var id: String?
    var image: UIImage?
    var name: String?
    var number:Int?
    var comment: String?
    
    init(snapshot: DataSnapshot, myId: String) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        
        self.name = valueDictionary["name"] as? String
        
        self.comment = valueDictionary["comment"] as? String
        
        self.number = valueDictionary["number"] as? Int
        
        }
    }
