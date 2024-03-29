﻿&НаКлиенте
Процедура ПересчитатьСуммуДокумента()
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьСтатьюЗатрат(Ссылка)
	Запрос = Новый Запрос();
	Запрос.Текст = "ВЫБРАТЬ
	               |	Номенклатура.СтатьяЗатрат КАК СтатьяЗатрат
	               |ИЗ
	               |	Справочник.Номенклатура КАК Номенклатура
	               |ГДЕ
	               |	Номенклатура.Ссылка = &Ссылка"; 
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	Возврат Выборка.СтатьяЗатрат;
КонецФункции

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	СтрокаТЧ = Элементы.Товары.ТекущиеДанные;
	РаботаСТабЧастямиКлиент.ПересчитатьСуммуВСтрТЧ(СтрокаТЧ);
	ПересчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	СтрокаТЧ = Элементы.Товары.ТекущиеДанные;
	РаботаСТабЧастямиКлиент.ПересчитатьСуммуВСтрТЧ(СтрокаТЧ);
	ПересчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	СтрокаТЧ = Элементы.Услуги.ТекущиеДанные;
	РаботаСТабЧастямиКлиент.ПересчитатьСуммуВСтрТЧ(СтрокаТЧ);
	ПересчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	СтрокаТЧ = Элементы.Услуги.ТекущиеДанные;
	РаботаСТабЧастямиКлиент.ПересчитатьСуммуВСтрТЧ(СтрокаТЧ);
	ПересчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура УслугиУслугаПриИзменении(Элемент)
	СтрокаТЧ = Элементы.Услуги.ТекущиеДанные;
	СтрокаТЧ.СтатьяЗатрат = ПолучитьСтатьюЗатрат(СтрокаТЧ.Услуга);
КонецПроцедуры




