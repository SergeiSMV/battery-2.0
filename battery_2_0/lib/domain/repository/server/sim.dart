

// Запрос всех комплектующих (СиМ)
String simAllItemsRoute = 'sim_all_items';


// Отправка QR кодов на почту (СиМ)
String simCreateQrcode = 'sim_create_qrcode';


// Информация о выбранной позиции
String simSelectedItem = 'sim_selected_item';

// Удаление выбранной позиции
String simDeleteItem = 'sim_delete_item';

// Получение списка категорий
String simGetCategories = 'sim_get_categories';

// Получение списка наименований по категории
String simGetNames = 'sim_get_names';

// Получение списка цветов по категории и наименованию
String simGetColors = 'sim_get_colors';

// Получение списка поставщиков по категории и наименованию
String simGetProducers = 'sim_get_producers';

// Получение списка поставщиков ВСЕХ
String simGetAllProducers = 'sim_get_all_producers';

// Получение списка ед. измерения по категории, наименованию и поставщику
String simGetUnits = 'sim_get_units';

// Сохранение отредактированной позиции
String simSaveItemEdit = 'sim_save_item_edit';

// Получение списка складов
String simGetPlaces = 'sim_get_places';

// Получение списка ячеек по наименованию склада
String simGetCells = 'sim_get_cells';

// перемещение ТМЦ
String simItemReplace = 'sim_item_replace';

// получение записей истории выбранной позиции
String simItemHistory = 'sim_item_history';

// изменение статуса ТМЦ
String simItemChangeStatus = 'sim_item_change_status';

// сохранить фото
String simItemSavePhoto = 'sim_item_save_photo';

// сохранить фото
String simItemDelPhoto = 'sim_item_del_photo';

// запрос информации по штрих коду
String simCheckBarcode = 'sim_check_barcode';

// проведение (сохранение) поступления
String simSaveComing = 'sim_save_coming';

// проверка существования id в базе items для идентификации
String checkItemIdExist = 'check_item_id_exist';






// Запрос всех заявок (СиМ)
String simAllOrders = 'sim_all_orders';

// запрос комплектующих по заявке (СиМ)
String simOrderItems = 'sim_order_items';

// Запрос уникальных комплектующих для создания заявки (СиМ)
String simUniqItems = 'sim_uniq_items';

// отправка заявки (сохранение в БД)
String simAddOrder = 'sim_add_order';

// запрос фактического остатка в базе ТМЦ по id (СиМ)
String simBaseItemQuantity = 'sim_base_item_quantity';

// выдача ТМЦ по заявке (СиМ)
String simItemExtradition = 'sim_item_extradition';

// приемка ТМЦ по заявке (СиМ)
String simAcceptExtradition = 'sim_accept_extradition';

