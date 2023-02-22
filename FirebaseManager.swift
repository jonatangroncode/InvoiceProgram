
/*
import SwiftUI
import Foundation
import FirebaseAuth
import Firebase
struct FirebaseManager {
var db = Firestore.firestore()
//@State var users =  [User]()
   

    func saveToFirestore(user :User) {


        do{
            _ = try    db.collection("users").addDocument(from: user)

        }catch {
            print("Error saving to DB")
        }

    }
    func listenToFirestore() -> [User] {
        var users =  [User]()
    db.collection("users").addSnapshotListener { snapshot, err in
        guard let snapshot = snapshot else {return}

        if let err = err {
            print("Error getting document \(err)")
        } else {
           users.removeAll()
            for document in snapshot.documents {

                print(document)
                let result = Result {
                    try document.data(as: User.self)

                }
                switch result  {
                case .success(let user)  :
                    users.append(user)
                    print(user)
                    print("added to  list")
                case .failure(let error) :
                    print("Error decoding item: \(error)")
                }

            }

        }
    }
        return users
    }


    func listenUserInFirestore() -> [User] {
        var users =  [User]()
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //users.append(document)
                   // print("\(document.documentID) => \(document.data())")
                    
                }
            }

        }
        return users
    }
}

    
    /*func getChosenClient(){
        
        for client in clients {
            //   print(user.email)
            // print(email)
            if(client.name == clientName){
                print("hittade!!")
                print(client.name ?? "")
                print(client.name ?? "")
                print(client.name ?? "")
                self.client = client
                
                
            }
        }
            
    }*/
    
    

    
    

*/
