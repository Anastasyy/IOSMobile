import Foundation
import SwiftData
import SwiftUI


@Model
class City {
    @Attribute(.unique) var name: String
    
    var latitude: Float
    var longitude: Float
    var descriptionText: String
    var isFavorite: Bool
    var assetName: String
    
    init(name: String, latitude: Float, longitude: Float, description: String, assetName: String, isFavorite: Bool = false) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.isFavorite = isFavorite
        self.descriptionText = description
        self.assetName = assetName

    }
}


extension City {
    @Transient
    var description: String {
        descriptionText.isEmpty ? "" : descriptionText
    }
    
}

extension City {
    static var preview: City {
        City(name: "Город Дедовичи", latitude:  57.545810, longitude: 29.940992, description: "В начале июня 1941 года, накануне начала Великой Отечественной войны, город Дедовичи, как и многие другие населенные пункты, ощущал напряженную обстановку и готовился к предстоящим событиям. В связи с наступающим конфликтом началась мобилизация, а также активизировались различные благотворительные и военные инициативы. Одной из таких инициатив было письмо в поддержку Ленинградцев, жителей Ленинграда (ныне Санкт-Петербурга), который впоследствии оказался под блокадой со стороны нацистской Германии. Городу угрожал голод, отсутствие товаров первой необходимости и продовольствия. Чтобы помочь жителям Ленинграда, различные регионы страны организовывали сбор продовольствия и других товаров. В Дедовичах это инициатива получила особую поддержку. Местные жители, взяв пример с других городов, активно собирали продукты питания, одежду, медикаменты и другие необходимые товары. Это было своеобразной поддержкой и проявлением солидарности с людьми, которые находились в трудной ситуации. Организовывались специальные точки сбора, где жители приносили свои пожертвования, демонстрируя взаимопомощь и единство в сложный для страны период. Этот момент в истории Дедовичей отмечает солидарность и готовность помочь людям в трудную минуту, что стало важной частью вклада местных жителей в общее дело победы в Великой Отечественной войне.", assetName: "dedovich")
    
        
    }
}

