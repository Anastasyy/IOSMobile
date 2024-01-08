import Foundation

struct Sample {
    static var contents: [City] = [
        City(name: "Город Дедовичи", latitude:  57.545810, longitude: 29.940992, description: "В начале июня 1941 года, накануне начала Великой Отечественной войны, город Дедовичи, как и многие другие населенные пункты, ощущал напряженную обстановку и готовился к предстоящим событиям. В связи с наступающим конфликтом началась мобилизация, а также активизировались различные благотворительные и военные инициативы. Одной из таких инициатив было письмо в поддержку Ленинградцев, жителей Ленинграда (ныне Санкт-Петербурга), который впоследствии оказался под блокадой со стороны нацистской Германии. Городу угрожал голод, отсутствие товаров первой необходимости и продовольствия. Чтобы помочь жителям Ленинграда, различные регионы страны организовывали сбор продовольствия и других товаров. В Дедовичах это инициатива получила особую поддержку. Местные жители, взяв пример с других городов, активно собирали продукты питания, одежду, медикаменты и другие необходимые товары. Это было своеобразной поддержкой и проявлением солидарности с людьми, которые находились в трудной ситуации. Организовывались специальные точки сбора, где жители приносили свои пожертвования, демонстрируя взаимопомощь и единство в сложный для страны период. Этот момент в истории Дедовичей отмечает солидарность и готовность помочь людям в трудную минуту, что стало важной частью вклада местных жителей в общее дело победы в Великой Отечественной войне.", assetName: "dedovich"),
        City(name: "Деревня Круглово", latitude:  57.477751, longitude:30.522589, description: "Деревня Круглово находится вблизи Ленинграда и тоже стала свидетельницей трагических событий тех лет. Ленинград был полностью изолирован от внешнего мира: население страдало от голода, холода и постоянных бомбежек. Дороги были перекрыты, а город был оборван от снабжения продовольствием и медикаментами. Жители Ленинграда и прилегающих деревень, включая Круглово, столкнулись с безмерной нуждой и голодом. Они были вынуждены использовать самые необычные источники пищи, бороться за выживание каждый день. Многие жертвовали своими последними запасами еды, чтобы помочь детям и старикам, и, несмотря на трудности, оставались вместе и поддерживали друг друга.Точка Круглово, вероятно, также стала местом, где люди объединялись для обмена информацией, помощи, попыток организовать какие-то виды помощи, несмотря на тяжелые условия. Они делились пищей, планами на будущее и опытом выживания. Это был период тяжелых потерь и стойкости, когда жители Ленинграда и близлежащих поселений, включая деревню Круглово, сражались за выживание и держались вместе, несмотря на все трудности и испытания. Их дух и сила помогли сохранить город и дали надежду на будущее.", assetName: "cruglovo"),
        City(name: "Деревня Нивки", latitude: 57.427104, longitude: 30.398935, description: "Каждое новое начало — это возможность для чего-то нового, но во времена войны начальные точки часто означали нечто большее. Деревня Нивки, в качестве начальной точки отправления обоза основной части, представляла начало путешествия, которое было нередко наполнено надеждой, опасностью и неизвестностью. Во времена войны начальная точка отправления обоза основной части означала подготовку к долгому и опасному путешествию. Здесь, в Деревне Нивки, люди собирались, готовясь к путешествию через опасные места, наполненные военными действиями. Это было место, где люди складывали последние запасы, обменивались планами и надеждами. Начальная точка отправления становилась своего рода отправной точкой для тех, кто решался на трудное и долгое путешествие через опасные территории. История начальных точек отправления во времена войны наполнялась смешением чувств — надежды на безопасное путешествие, боязни за будущее, смелости и решимости двигаться вперед, несмотря ни на что. В месте, которое стало отправной точкой для обоза основной части, люди делились последними словами прощания, надеясь на встречу в будущем. Это место стало символом начала чего-то нового и в то же время напоминанием о том, сколько еще предстоит преодолеть, прежде чем достичь цели.", assetName: "nivki"),
        City(name: "Деревня Краснодубье",latitude:  57.441371, longitude:30.729432 , description: "", assetName: "dedovich"),
        City(name: "Деревня Мухарево", latitude:   57.412464, longitude: 30.407634, description: "", assetName: "dedovich"),
        City(name: "Деревня Татинец", latitude:  57.391278, longitude: 30.468313, description: "", assetName: "dedovich"),
        City(name: "Деревня Глотово", latitude:  57.349806, longitude: 30.512257, description: "", assetName: "dedovich"),
        City(name: "Озеро Прудское", latitude:  57.343858, longitude:  30.590531, description: "", assetName: "dedovich"),
        City(name: "Деревня Притчино", latitude: 57.358600, longitude:  30.652400, description: "", assetName: "dedovich"),
        City(name: "Деревня Вичевицы",  latitude: 57.374398, longitude:  30.724507, description: "", assetName: "dedovich"),
        City(name: "Деревня Иванцево", latitude:  57.364230, longitude:  30.779008, description: "", assetName: "dedovich"),
        City(name: "Деревня Сосново", latitude:   57.389413, longitude:  30.865092, description: "", assetName: "dedovich"),
        City(name: "Деревня Лопари", latitude:    57.337130, longitude:  31.010616, description: "", assetName: "dedovich"),
        City(name: "Линия фронта", latitude:     57.351353, longitude:  31.021244, description: "", assetName: "dedovich"),
        City(name: "Деревня Студеново", latitude:    57.354699, longitude:  31.129729, description: "", assetName: "dedovich"),
        City(name: "Город Осташков", latitude:    57.153026, longitude:  33.101540, description: "", assetName: "dedovich"),
        City(name: "Ж/Д станция Черный Дор", latitude:    57.239631, longitude:  33.292420, description: "", assetName: "dedovich"),
        City(name: "Деревня Перегино", latitude:     57.446861, longitude:  31.383588, description: "", assetName: "dedovich"),
        City(name: "Деревня Рахлицы", latitude:     57.610672, longitude:  31.483356, description: "",assetName: "dedovich"),
    ]
}
