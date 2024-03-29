﻿ Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	Если НЕ ЗначениеЗаполнено(Ответственный) Тогда
		Ответственный = ПараметрыСеанса.ТекущийПользователь;
	КонецЕсли;
	
	ДлительностьУслуг = РассчитатьДатуОкончанияЗаписи();
	Если ДлительностьУслуг = 0 Тогда
    	ДлительностьУслуг = 30;
	КонецЕсли;
	ДатаОкончанияЗаписи = ДатаЗаписи + ДлительностьУслуг * 60;
КонецПроцедуры

Функция РассчитатьДатуОкончанияЗаписи()
	ТЧУслуги = Услуги.Выгрузить(,"Услуга"); 
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ТЧУслуги", ТЧУслуги);
	Запрос.Текст=
	"ВЫБРАТЬ
	|	ТЧУслуги.Услуга КАК Услуга
	|ПОМЕСТИТЬ ВТ_Услуга
	|ИЗ
	|	&ТЧУслуги КАК ТЧУслуги
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СУММА(Номенклатура.ДлительностьУслуги) КАК ДлительностьУслуги
	|ИЗ
	|	ВТ_Услуга КАК ВТ_Услуга
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК Номенклатура
	|		ПО ВТ_Услуга.Услуга = Номенклатура.Ссылка";

	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	Если Выборка.ДлительностьУслуги = Null Тогда
		Возврат 0;
	Иначе
		Возврат Выборка.ДлительностьУслуги;
	КонецЕсли;
КонецФункции

Процедура ОбработкаПроведения(Отказ, Режим)
	// регистр ЗаказыКлиентов Приход
	Движения.ЗаказыКлиентов.Записывать = Истина;
	Движение = Движения.ЗаказыКлиентов.Добавить();
	Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
	Движение.Период = ДатаЗаписи;
	Движение.Клиент = Клиент;
	Движение.ЗаказКлиента = Ссылка;
	Движение.Сумма = СуммаДокумента;
КонецПроцедуры
