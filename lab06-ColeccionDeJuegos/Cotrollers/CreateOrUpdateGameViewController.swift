import UIKit

class CreateOrUpdateGameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var btnCameraOrGalery: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
    }
    
    @IBAction func onClickAlertCameraOrGalery(_ sender: Any) {
        
        let alert = UIAlertController(title: "Semana 6", message: "¿Quieres acceder a la galeria o a la camara?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camata", style: .default, handler: {
            _ in self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Galeria", style: .default, handler: {
            _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = imageSelected
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
}
