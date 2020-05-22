//  В этом файле у нас вся логика нашего приложения
//  Все бизнес процессы мы опишем здесь:
//  -сохранение данных, подгрузку данных
//  -создание новых todo айтемов
//  Ну и вообще, все манипуляции с ними
//  "кухня"

import Foundation

// здесь не словарь, а массив словарей
var dictOfItemS: [[String: Any]] = [["key1": "СделатьA", "isCheck": true],  //такого рода
                                     ["key1": "СделатьB", "isCheck": false],
                                     ["key1": "СделатьC", "isCheck": false]]

//Метод для добавления нового item
func addIteM(iteM: String, isCompleted: Bool = false) {
    dictOfItemS.append(["key1": iteM, "isCheck": isCompleted])
    saveDatA()
}


//Удаление
func ridIteM(atIndex: Int) {
    dictOfItemS.remove(at: atIndex)
    saveDatA()
}

//Меняем состояние ячейки т.е. галочки
func changeCheck(item: Int){
    //делается просто. Берем состояние и приравниваем его противоположному
    dictOfItemS[item]["isCheck"] = !(dictOfItemS[item]["isCheck"] as! Bool)
    saveDatA()
}

//сохр
func saveDatA() {
    //UserDefaults это словарь в котором можно перманентно записать какие  то данные
    //контейнеры для хранения значений по ключу
    UserDefaults.standard.set(dictOfItemS, forKey: "someKey")
    //и выполняем синхронизацию
    UserDefaults.standard.synchronize() //??
    
    print("save save")
}

//загрузка при запуске
func loadDаtA() {
    //Чтобы загрузить данные мы обращаемся к UserDefaults. Но данные из UserDefaults приходят типа: [Any]?
    //поэтому мы пришедший словарь сразу и преобразовываем в [[String: Any]]
    //походу проверяем есть ли что-нибудь в UserDefaults по ключу "someKey" что можно преобразовать в [[String: Any]]
    if let array = UserDefaults.standard.array(forKey: "someKey") as? [[String: Any]] {
        //если есть ->
        dictOfItemS = array
    } else {
        //этот кейс может быть когда мы запускаем app в первый раз и он пустой
        dictOfItemS = []
    }
    //эту функцию запускаем в AppDelegate
}
