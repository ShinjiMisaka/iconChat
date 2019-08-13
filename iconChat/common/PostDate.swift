import UIKit
import Firebase

class PostData: NSObject {
    var id: String?
    var name: String?
    var comment: String?
    var image: UIImage?
    var imageString: String?
    var uid: String?
    
    
    init(snapshot: DataSnapshot, myId: String) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!)
        
        self.name = valueDictionary["name"] as? String
        
        self.comment = valueDictionary["comment"] as? String
        
        self.uid = valueDictionary["uid"] as? String
        
        }
    }
