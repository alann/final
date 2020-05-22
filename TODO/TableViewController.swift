// это файл посредник "официант" в кафе который берет заказы у клиентов в (Main.storyboard)
// и передает их в "кухню" (Model)
// или берет готовые блюда из "кухни" и относит их клиенту,
// который видит блюдо, но не особо представляет как оно приготовлено
// суть mvc


import UIKit

class TableViewController: UITableViewController {

    //вызывается когда нажимаем на "+"
    @IBAction func pushAddActioN(_ sender: Any) {
        
//        addIteM(iteM: "Новая задача") //подрубаем наш addItem
//        вместо всего этого используем ALERT
        let alertControleR = UIAlertController(title: "Добавить", message: nil, preferredStyle: .alert)
        
        //текстовое поле у UIAlertController
        alertControleR.addTextField { (textField) in
            textField.placeholder = "Добавьте задачу" //не обязательно
            
        }
        
        //кнопки у UIAlertController
        let alertAction1 = UIAlertAction(title: "cancel", style: .default)
        //блок кода кот будет выполняться при нажатии на эту кнопку
        { (alert) in
        
        }
        
        let alertAction2 = UIAlertAction(title: "create", style: .default)
        //блок кода, действия при нажатии на alertAction2
        { (alert) in
            //добавляем новую запись
            
            //у alertControleR есть opt массив textFields,
            //т.к. поле одно, то и обращаемся к textFields[0]
            let newIteM = alertControleR.textFields![0].text
            addIteM(iteM: newIteM!)
            //при добавлении новой задачи он обновляет нашу таблицу
            self.tableView.reloadData()
        }
        
        
        //alertу добавляем кнопки create и cancel
        alertControleR.addAction(alertAction1)
        alertControleR.addAction(alertAction2)
        //вызываем alert
        present(alertControleR, animated: true, completion: nil)
        //в completion можно запихать блок кода, кот будет выполняться когда открываем alert
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 //кол-во секций
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return dictOfItemS.count //кол-во записей в секции
    }

    //генерация ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ИдентификаторЯчейки", for: indexPath)
        
        
        
        //здесь мы берем один item из массива словарей
        let currentIteM  = dictOfItemS[indexPath.row]
        //и тексту ячейки передаем значение по ключу "key"
        cell.textLabel?.text = currentIteM["key1"] as? String //ну тут понятно

        //берем объект из словаря по ключу "isCheck"
        //и если он = true
        if (currentIteM["isCheck"] as? Bool) == true {
            //то ставим галочку
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
   

        return cell
    }
    
    
    
    

    // 2 метода для удаления ячейки
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //для удаления ячейки
        if editingStyle == .delete {
            
            ridIteM(atIndex: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
               //для редактирования ячейки
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    //метод для обработки нажатия на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //первым делом снимаем выделение
        tableView.deselectRow(at: indexPath, animated: true)
        
        //меняем значение
        changeCheck(item: indexPath.row)
        tableView.reloadData()
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
