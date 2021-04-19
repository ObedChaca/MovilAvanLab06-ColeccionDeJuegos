import UIKit

class CreateOrUpdateGameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var btnCameraOrGalery: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    
    @IBOutlet weak var tituloTextField: UITextField!
    
    
    
    var imagePicker = UIImagePickerController()
    
    var juego: Juego? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
        if juego != nil {
            imageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden = true
        }
        
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
    
    @IBAction func agregarTapped(_ sender: Any) {
        
        if juego != nil{
            let imageData = imageView.image!.pngData()! as NSData
            juego!.titulo = tituloTextField.text
            juego!.imagen = imageData as Data
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            let imageData = imageView.image!.pngData()! as NSData
            juego.titulo = tituloTextField.text
            juego.imagen = imageData as Data
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    
}
