﻿&НаКлиенте
Процедура УстановитьВидимость()
	Элементы.ДатаОкончания.Видимость = НЕ Объект.Бессрочный;
КонецПроцедуры

&НаКлиенте
Процедура СформироватьНаименование()	
	Объект.Наименование = "№" + Объект.Номер + " от " + Формат(Объект.ДатаНачала, "ДЛФ=ДД");	
КонецПроцедуры

&НаКлиенте
Процедура БессрочныйПриИзменении(Элемент)
	УстановитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УстановитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура ДатаНачалаПриИзменении(Элемент)
	СформироватьНаименование();
КонецПроцедуры

&НаКлиенте
Процедура НомерПриИзменении(Элемент)
	СформироватьНаименование();
КонецПроцедуры
