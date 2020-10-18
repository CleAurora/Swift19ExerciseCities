//
//  ViewController.swift
//  CityExercise
//
//  Created by Cleís Aurora Pereira on 15/10/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pickerView: UIPickerView!

    var cityArray = [City]()
    var stateArray = [String]()
    var countryArray = [String]()
    var filteredArray = [City]()
    var stateSelected: String?
    var countrySelected: String?
    var textInSearchBar: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        pickerView.delegate = self
        pickerView.dataSource = self
        searchBar.delegate = self

        cityArray.append(City(name: "São Paulo", state: "São Paulo", country: "Brasil", numberPeople: 13000000, temperature: 26.7, coordinates: CLLocation(latitude: -23.5489, longitude: -46.6388)))
        cityArray.append(City(name: "Campos do Jordão", state: "São Paulo", country: "Brasil", numberPeople: 25000, temperature: 8.9, coordinates: CLLocation(latitude: -22.7386, longitude: -45.5921)))
        cityArray.append(City(name: "Olímpia", state: "São Paulo", country: "Brasil", numberPeople: 10900, temperature: 36.7, coordinates: CLLocation(latitude: -20.7366, longitude: -48.9106)))
        cityArray.append(City(name: "Sorocaba", state: "São Paulo", country: "Brasil", numberPeople: 19300, temperature: 28.7, coordinates: CLLocation(latitude: -23.4969, longitude: -47.4451)))
        cityArray.append(City(name: "Peruíbe", state: "São Paulo", country: "Brasil", numberPeople: 20000, temperature: 30.5, coordinates: CLLocation(latitude: -24.3173, longitude: -46.9956)))
        cityArray.append(City(name: "Rio de Janeiro", state: "Rio de Janeiro", country: "Brasil", numberPeople: 8000000, temperature: 30.6,coordinates: CLLocation(latitude: -22.9035, longitude: -43.2096)))
        cityArray.append(City(name: "Buzios", state: "Rio de Janeiro", country: "Brasil", numberPeople: 300000, temperature: 31.5, coordinates: CLLocation(latitude: -22.7481, longitude: -41.8813)))
        cityArray.append(City(name: "Cabo Frio", state: "Rio de Janeiro", country: "Brasil", numberPeople: 29000, temperature: 29.6, coordinates: CLLocation(latitude: -22.8787, longitude: -42.0199)))
        cityArray.append(City(name: "Petrópolis", state: "Rio de Janeiro", country: "Brasil", numberPeople: 26000, temperature: 30.0, coordinates: CLLocation(latitude:  -22.5046, longitude: -43.1823)))
        cityArray.append(City(name: "Miami", state: "Flórida", country: "Estados Unidos", numberPeople: 13000000, temperature: 30.5, coordinates: CLLocation(latitude: 25.7751, longitude: -80.2105 )))
        cityArray.append(City(name: "Orlando", state: "Flórida", country: "Estados Unidos", numberPeople: 15000000, temperature: 30.9, coordinates: CLLocation(latitude: 28.4159, longitude: -81.2988)))
        cityArray.append(City(name: "Austin", state: "Texas", country: "Estados Unidos", numberPeople: 13000000, temperature: 30.5, coordinates: CLLocation(latitude: 30.267222, longitude: -97.763889)))
        cityArray.append(City(name: "Araguaína", state: "Tocantins", country: "Brasil", numberPeople: 13000000, temperature: 30.5,coordinates: CLLocation(latitude: -7.19207, longitude: -48.2078)))
        cityArray.append(City(name: "Palmas", state: "Tocantins", country: "Brasil", numberPeople: 13000000, temperature: 30.5, coordinates: CLLocation(latitude: -10.1689, longitude: -48.3317)))
        cityArray.append(City(name: "Belém", state: "Pará", country: "Brasil", numberPeople: 13000000, temperature: 30.5, coordinates: CLLocation(latitude: -1.45502, longitude: -48.5024)))
        filteredArray = cityArray
        stateArray = Array(Set(cityArray.map({ (city) -> String in
            city.state
        })))
        countryArray = Array(Set(cityArray.map({ (city) -> String in
            city.country
        })))
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityDetailViewController = UIStoryboard(name: "CityDetail", bundle: nil).instantiateInitialViewController() as! CityDetailViewController
        cityDetailViewController.city = filteredArray[indexPath.row]

        present(cityDetailViewController, animated: true, completion: nil)
    }

}

extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            if row == 0 {
                stateSelected = nil
            }else{
                stateSelected = stateArray[row - 1]
            }
        }else if component == 1{
            if row == 0{
                countrySelected = nil
            }else{
                countrySelected = countryArray[row - 1]
            }
        }

        filter()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textInSearchBar = searchText

        filter()
    }

    func filter() {
        if textInSearchBar.isEmpty && countrySelected == nil && stateSelected == nil {
            filteredArray = cityArray
        } else {
            let searchText = textInSearchBar.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil)

            filteredArray = cityArray.filter({ (city) -> Bool in
                var canAppear = true

                if let country = countrySelected {
                    canAppear = canAppear && city.country == country
                }

                if let state = stateSelected{
                    canAppear = canAppear && city.state == state
                }

                return canAppear
            })
            .filter({ (city) -> Bool in
                if searchText.isEmpty {
                    return true
                }

                return city.name.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil).contains(searchText) ||
                city.state.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil).contains(searchText) ||
                city.country.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil).contains(searchText)
            })
        }

        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CityCell

        cell.setup(city: filteredArray[indexPath.row])
        return cell
    }
}

extension ViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "Todos"
        }

        if component == 0 {
            return stateArray[row-1]
        }else if component == 1{
            return countryArray[row-1]
        }else{
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return stateArray.count + 1
        } else if component == 1{
            return countryArray.count + 1
        }else{
            return 0
        }
    }



    
}
