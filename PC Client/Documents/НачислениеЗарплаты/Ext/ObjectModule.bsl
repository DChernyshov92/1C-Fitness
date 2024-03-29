﻿ Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	Если НЕ ЗначениеЗаполнено(Ответственный) Тогда
		Ответственный = ПараметрыСеанса.ТекущийПользователь;
	КонецЕсли;
КонецПроцедуры


Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	Движения.Начисления.Записывать = Истина;
	Движения.УчётЗатрат.Записывать = Истина;
	Движения.Хозрасчётный.Записывать = Истина;
	
	Для Каждого ТекСтрокаНачисления Из Начисления Цикл
		Движение = Движения.Начисления.Добавить();
		Движение.Сторно = Ложь;
		Движение.ВидРасчета = ТекСтрокаНачисления.ВидРасчета;
		Движение.ПериодДействияНачало = ТекСтрокаНачисления.ДатаНачала;
		Движение.ПериодДействияКонец = ТекСтрокаНачисления.ДатаОкончания;
		Движение.ПериодРегистрации = ПериодНачисления;
		Движение.БазовыйПериодНачало = ТекСтрокаНачисления.ДатаНачала;
		Движение.БазовыйПериодКонец = ТекСтрокаНачисления.ДатаОкончания;
		Движение.Сотрудник = ТекСтрокаНачисления.Сотрудник;
		Движение.ПоказательРасчета = ТекСтрокаНачисления.ПоказательРасчета;
		Движение.График = ТекСтрокаНачисления.ГрафикРаботы;
	КонецЦикла;
	
	Движения.Начисления.Записать();
	Движения.Начисления.РассчитатьСуммуНачисления();
	
	Запрос = Новый Запрос;
    Запрос.Текст = 
    "ВЫБРАТЬ
    |    Начисления.Сотрудник КАК Сотрудник,
    |    Начисления.Сумма КАК Сумма,
    |    Начисления.ВидРасчета.СтатьяЗатрат КАК СтатьяЗатрат
    |ИЗ
    |    РегистрРасчета.Начисления КАК Начисления
    |ГДЕ
    |    Начисления.Регистратор = &Регистратор
    |ИТОГИ
    |    СУММА(Сумма)
    |ПО
    |    СтатьяЗатрат";
    Запрос.УстановитьПараметр("Регистратор", ЭтотОбъект.Ссылка);
    
    РезультатЗапроса = Запрос.Выполнить();
    ВыборкаИтогиПоСтатье = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);

	Пока ВыборкаИтогиПоСтатье.Следующий() Цикл
        ДвижениеЗатрат = Движения.УчётЗатрат.Добавить();
        ДвижениеЗатрат.Период = Дата;
        ДвижениеЗатрат.СтатьяЗатрат = ВыборкаИтогиПоСтатье.СтатьяЗатрат;
		ДвижениеЗатрат.Сумма = ВыборкаИтогиПоСтатье.Сумма;
		ВыборкаДетальные = ВыборкаИтогиПоСтатье.Выбрать(); 
        Пока ВыборкаДетальные.Следующий() Цикл
            ДвижениеХозрасчётный = Движения.Хозрасчётный.Добавить();
            ДвижениеХозрасчётный.СчетДт = ПланыСчетов.Хозрасчётный.РасходыНаПродажу;
            ДвижениеХозрасчётный.СчетКт = ПланыСчетов.Хозрасчётный.РасчетыСПерсоналомПоОплатеТруда;
            ДвижениеХозрасчётный.Период = Дата;
            ДвижениеХозрасчётный.Сумма = ВыборкаДетальные.Сумма;
            ДвижениеХозрасчётный.Содержание = "Отражено начисление заработной платы сотрудникам";
            БухгалтерскийУчёт.ЗаполнитьСубконтоПоСчету(ДвижениеХозрасчётный.СчетДт, 
                    ДвижениеХозрасчётный.СубконтоДт, ВыборкаДетальные.СтатьяЗатрат);
            БухгалтерскийУчёт.ЗаполнитьСубконтоПоСчету(ДвижениеХозрасчётный.СчетКт, 
                    ДвижениеХозрасчётный.СубконтоКт, ВыборкаДетальные.Сотрудник);
        КонецЦикла;
	КонецЦикла;
КонецПроцедуры
