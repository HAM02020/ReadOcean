import UIKit


extension UIImage{
    struct Filter {
            let filterName: String
            var filterEffectValue: Any?
            var filterEffectValueName: String?
            
            init(filterName: String, filterEffectValue: Any?, filterEffectValueName: String?){
                self.filterName = filterName
                self.filterEffectValue = filterEffectValue
                self.filterEffectValueName = filterEffectValueName
            }
            
            
        }
        
    func blur()->UIImage?{
        let filterEffect = Filter(filterName: "CIGaussianBlur", filterEffectValue: 8.0, filterEffectValueName: kCIInputRadiusKey)
        
        return applyFilterTo(image: self, filterEffect: filterEffect)
    }
        
    func applyFilterTo(image: UIImage, filterEffect: Filter) -> UIImage? {
        
    guard let cgImage = image.cgImage,
          let openGLcontext = EAGLContext(api: .openGLES3) else {
            return nil
        }
        let context = CIContext(eaglContext: openGLcontext)
        
        let ciImage = CIImage(cgImage: cgImage)
        let filter = CIFilter(name: filterEffect.filterName)
        
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        if let filterEffectValue = filterEffect.filterEffectValue,
        let filterEffectValueName = filterEffect.filterEffectValueName {
            filter?.setValue(filterEffectValue, forKey: filterEffectValueName)
        }
        
        var filteredImage: UIImage?
        
        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage,
            let cgiImageResult = context.createCGImage(output, from: output.extent){
            filteredImage = UIImage(cgImage: cgiImageResult)
        }
        return filteredImage
        
    }
}



