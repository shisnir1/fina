

import UIKit

public protocol LanguageProtocol {
    
    func getSelectedLanguage(languageName: String)
}

public protocol CountryProtocol {
    
    func getSelectedCountryCode(countryCode: String)
}

class ChoiceListController: UIViewController {

    @IBOutlet weak var choiceListTableView: UITableView!
    
    let defaultCountryFlagImage = #imageLiteral(resourceName: "globe")
    var languageDelegate: LanguageProtocol!
    var countryDelegate: CountryProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib.init(nibName: "ChoiceCell", bundle: nil)
        choiceListTableView.register(nib, forCellReuseIdentifier: "choicecell")
        
        let nib2 = UINib.init(nibName: "CountryListCell", bundle: nil)
        choiceListTableView.register(nib2, forCellReuseIdentifier: "countrylistcell")
    }

}

extension ChoiceListController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch AccountController.choice {
        case .country:
            return CountryList.countryItems.count
        
        case .language:
            return LanguageList.languageItem.count
        
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Configuring cell based on where user came from (Country or Language)
        
        switch AccountController.choice {
        case .country:
            let cell = choiceListTableView.dequeueReusableCell(withIdentifier: "countrylistcell", for: indexPath) as! CountryListCell
            cell.countryNameLabel.text = CountryList.countryItems[indexPath.row].countryName
            
            if let url = URL(string: "https://www.countryflags.io/\(CountryList.countryCodes[indexPath.row])/shiny/64.png") {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            
                            cell.setCountryFlagImageView(image: UIImage(data: data) ?? self.defaultCountryFlagImage)
                            cell.countryFlagImageView.contentMode = .scaleAspectFill
                        }
                    }
                }.resume()
                
            }
            
            return cell
        
        default:
            let cell = choiceListTableView.dequeueReusableCell(withIdentifier: "choicecell", for: indexPath) as! ChoiceCell
            cell.countryNameLabel.text = "\(LanguageList.languageItem[indexPath.row].languageName)"
            return cell
        
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if AccountController.choice == .country {
            let countryCodeString = CountryList.countryCodes[indexPath.row]
            countryDelegate.getSelectedCountryCode(countryCode: countryCodeString)

        }
            
        else{
            let languageCodeString = LanguageList.languageCodes[indexPath.row]
            languageDelegate.getSelectedLanguage(languageName: languageCodeString)

        }

        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    
}
