% Определение предикатов для компонентов
/*PREDICATES
 Материнская плата  (motherboard)
motherboard(Model, FormFactor, Socket, RAMType, MaxRAMSlots, DiskInterfaces, VideoPorts, Price).

 Центральный процессор (CPU)
cpu(Model, Frequency, Cores, Socket, IntegratedGPU, Price).

 Видеокарта (GPU)
gpu(Model, GPUProcessor, GPUMemory, MemoryType, BusType, MemoryFrequency, Price).

 Оперативная память (RAM)
ram(Model, Size, MemoryType, Modules, Frequency, Price).

 Корпус (case)
case(Model, Material, SupportedFormFactors, Price).

 Блок питания (PSU)
psu(Model, Power, EfficiencyRating, Price).

 Твердотельный накопитель (SSD)
ssd(Model, Capacity, Interface, Price).

 Жесткий диск (HDD)
hdd(Model, Capacity, Interface, Price).

 Монитор
monitor(Model, Resolution, PanelType, Port, Price).

CLAUSES*/
% Определение предиката для хранения выбранных компонентов

:- dynamic(component/2).
:- dynamic(max_price/1).
%----------------------------------------------------------------------------------------
% материнская плата (motherboard)
motherboard('GIGABYTE B450 AORUS ELITE', atx, am4, ddr4, 1, [sata_3, nvme], [hdmi, vga, dvi, displayport], 9100).
motherboard('MSI DDR3 B550 TOMAHAWK', atx, am4, ddr3, 4, [sata_3, nvme, m2], [hdmi, vga, dvi], 10500).
motherboard('ASRock X570 Phantom Gaming 4', atx, am4, ddr4, 4, [sata_3, nvme, m2], [vga, dvi], 11900).
motherboard('ASUS LGA Strix B550-F Gaming', mini_itx, lga_1200, ddr4, 2, [sata_3, nvme], [hdmi, dvi, vga], 12600).

% Центральный процессор (CPU)
cpu('Intel Core i9-11900K', 3.5, 8, lga_1200, no, 35000).
cpu('AMD Ryzen 7 5800X', 3.8, 8, am4, no, 31500).
cpu('Intel Core i5-11600K', 3.9, 6, lga_1200, no, 21000).
cpu('AMD Ryzen 5 5600X', 3.7, 6, am4, no, 19600).
cpu('AMD Ryzen 5 5600X Used', 3.7, 6, am4, no, 10000).

% Видеокарта (GPU)
gpu('AMD Radeon RX 6700 XT', rdna_2, 12, ddr6, pcie_4, 16000, 42000).
gpu('NVIDIA GeForce RTX 3060 Ti', ampere, 8, ddr3, pcie_4, 14000, 35000).
gpu('NVIDIA GeForce RTX 1650 Ti', ampere, 8, ddr4, pcie_4, 14000, 17500).
gpu('AMD Radeon RX 6800', rdna_2, 16, ddr6, pcie_4, 16000, 49000).
gpu('NVIDIA GeForce RTX 3070', ampere, 8, ddr6, pcie_4, 15000, 45500).

% Оперативная память (RAM)
ram('Crucial Ballistix 16GB (2 x 8GB) DDR4-3200', 16, ddr4, 2, 3200, 5600).
ram('G.Skill Trident Z RGB 32GB (2 x 16GB) DDR6-3600', 32, ddr6, 2, 3600, 10500).
ram('Corsair Dominator Platinum RGB 64GB (4 x 16GB) DDR4-4000', 64, ddr4, 4, 4000, 21000).
ram('Kingston HyperX Fury 8GB DDR3-2666', 8, ddr3, 1, 2666, 2800).

% Корпус (Case)
case('Cooler Master MasterBox Q300L', steel, [atx, micro_atx, mini_itx], 4200).
case('NZXT H510', steel, [atx, micro_atx, mini_itx], 4900).
case('Phanteks Eclipse P400A', steel, [atx, micro_atx], 5600).
case('Fractal Design Meshify C', steel, [micro_atx, mini_itx], 6300).

% Блок питания (PSU)
psu('EVGA SuperNOVA 750 G5', 750, gold, 9100).
psu('Seasonic FOCUS GX-850', 850, gold, 10500).
psu('Corsair RM750', 750, gold, 8400).
psu('be quiet! Straight Power 11 750W', 750, platinum, 11200).
psu('Rebel 600W', 600, gold, 4500).

% Твердотельный накопитель (SSD)
ssd('Crucial P2 1TB NVMe M.2', 1000, nvme, 7000).
ssd('Samsung 980 PRO 500GB NVMe M.2', 500, nvme, 8400).
ssd('Western Digital Blue SN550 2TB NVMe M.2', 2000, nvme, 17500).
ssd('ADATA XPG SX8200 Pro 512GB M.2', 512, m2, 6300).

% Жесткий диск (HDD)
hdd('Western Digital Blue 2TB 7200 RPM', 2000, sata_3, 3500).
hdd('Seagate FireCuda 2TB 7200 RPM', 2000, sata_3, 4200).
hdd('Toshiba P300 3TB 7200 RPM', 3000, sata_3, 4900).
hdd('Hitachi Deskstar 4TB 7200 RPM', 4000, sata_3, 7000).

% Монитор
monitor('Dell S2721DGF', '2560x1440', ips, vga, 21000).
monitor('LG 27GL850-B', '2560x1440', ips, dvi, 22400).
monitor('Acer Predator XB271HU', '2560x1440', ips, hdmi, 24500).
monitor('ASUS ROG Swift PG279Q', '2560x1440', ips, hdmi, 28000).
monitor('SUNWIND DISPLAYPORT TEST', '1920x1080', ips, displayport, 14000).
%----------------------------------------------------------------------------------------
% Обновление компонента в списке
update_component(Component, Components, Type, NewComponents) :-
    delete(Components, component(Type, _), TempComponents),
    append(TempComponents, [component(Type, Component)], NewComponents).

% Удаление компонента из списка компонентов
remove_component(Type, Components, NewComponents) :-
    select(component(Type, _), Components, NewComponents).

% Обновление максимальной цены
update_max_price(NewMaxPrice) :-
    retractall(max_price(_)),  % Удаляем предыдущую запись максимальной цены
    assertz(max_price(NewMaxPrice)).  % Добавляем новую максимальную цену

% Запуск программы
start :-
    write('Welcome to the PC Building System!'), nl,
    main_menu([], 0).
%----------------------------------------------------------------------------------------
% Главное меню с учётом максимальной цены
main_menu(Components, MaxPrice) :-
    (max_price(MaxPrice) -> true; MaxPrice = 0),  % Проверяем текущую максимальную цену
    write('Current components: '), nl,
    print_components(Components),
    total_price(Components, TotalPrice),
    format('Total price: ~w RUB', [TotalPrice]), nl,
    format('Maximum price: ~w RUB', [MaxPrice]), nl,
    write('1. Choose Motherboard'), nl,
    write('2. Choose CPU'), nl,
    write('3. Choose GPU (Graphics Card)'), nl,
    write('4. Choose RAM (Memory)'), nl,
    write('5. Choose Case'), nl,
    write('6. Choose Power Supply Unit (PSU)'), nl,
    write('7. Choose Storage'), nl,
    write('8. Choose Monitor'), nl,
    write('9. Set Maximum Price'), nl,
    write('10. Remove Component / Components'), nl,
    write('0. Exit'), nl,
    read(Choice),
    handle_choice(Choice, Components, MaxPrice).

% Печать текущих компонентов
print_components([]) :-
    write('-------------------'), nl.

print_components([component(Type, Model)|T]) :-
    component_price(Model, Price),
    format('~w: ~w | ~w RUB~n', [Type, Model, Price]),
    print_components(T).
% сумма текущих компонентов
total_price([], 0).

total_price([H|T], Total) :-
    component_price(H, Price),
    total_price(T, Rest),
    Total is Price + Rest.
% Цена добавленного компонента
component_price(component(Type, Model), Price) :-
    (   Type = motherboard, motherboard(Model, _, _, _, _, _, _, Price)
    ;   Type = cpu, cpu(Model, _, _, _, _, Price)
    ;   Type = gpu, gpu(Model, _, _, _, _, _, Price)
    ;   Type = ram, ram(Model, _, _, _, _, Price)
    ;   Type = case, case(Model, _, _, Price)
    ;   Type = psu, psu(Model, _, _, Price)
    ;   Type = ssd, ssd(Model, _, _, Price)
    ;   Type = hdd, hdd(Model, _, _, Price)
    ;   Type = monitor, monitor(Model, _, _, _, Price)
    ).
% Цена компонента
component_price(Model, Price) :-
    (   motherboard(Model, _, _, _, _, _, _, Price)
    ;   cpu(Model, _, _, _, _, Price)
    ;   gpu(Model, _, _, _, _, _, Price)
    ;   ram(Model, _, _, _, _, Price)
    ;   case(Model, _, _, Price)
    ;   psu(Model, _, _, Price)
    ;   ssd(Model, _, _, Price)
    ;   hdd(Model, _, _, Price)
    ;   monitor(Model, _, _, _, Price)
    ).

%----------------------------------------------------------------------------------------
% Обработка выбора пользователя
handle_choice(0, _, _) :-
    writeln('Exiting... Goodbye!').

handle_choice(1, Components, _) :-
    choose_motherboard(Components).

handle_choice(2, Components, _) :-
    choose_cpu(Components).

handle_choice(3, Components, _) :-
    choose_gpu(Components).

handle_choice(4, Components, _) :-
    choose_ram(Components).

handle_choice(5, Components, _) :-
    choose_case(Components).

handle_choice(6, Components, _) :-
    choose_psu(Components).

handle_choice(7, Components, _) :-
    submenu_storage(Components).

handle_choice(8, Components, _) :-
    choose_monitor(Components).

% Обработка выбора пользователя в главном меню
handle_choice(9, Components, _) :-
    write('You can set your maximum price for you PC assembly.'), nl,
    write('DEFAULT VALUE = 0 - No price limit.'), nl,
    write('Enter the maximum price (in RUB): '), nl,
    read(NewMaxPrice),
    update_max_price(NewMaxPrice),  % Обновление максимальной цены
    main_menu(Components, NewMaxPrice).

handle_choice(10, Components, _) :-
    remove_component_menu(Components).

handle_choice(_, Components, _) :-
    write('Invalid choice. Please try again.'), nl,
    main_menu(Components, _).



%----------------------------------------------------------------------------------------
% Проверка совместимости компонентов
compatible_motherboard_cpu(Motherboard, CPU) :-
    motherboard(Motherboard, _, _, _, _, _, _, _),
    cpu(CPU, _, _, Socket, _, _),
    motherboard(Motherboard, _, Socket, _, _, _, _, _).

compatible_motherboard_gpu(Motherboard, GPU) :-
    motherboard(Motherboard, _, _, _, _, _, _, _),
    gpu(GPU, _, _, MemoryType, _, _, _),
    motherboard(Motherboard, _, _, MemoryType, _, _, _, _).

compatible_motherboard_ram(Motherboard, RAM) :-
    motherboard(Motherboard, _, _, RAMType, MaxRAMSlots, _, _, _),
    ram(RAM, _, RAMType, Modules, _, _),
    Modules =< MaxRAMSlots.
compatible_ram_gpu(RAM, GPU) :-
    ram(RAM, _, MemoryType, _, _, _),
    gpu(GPU, _, _, MemoryType, _, _, _).

compatible_case_motherboard(Case, Motherboard) :-
    case(Case, _, SupportedFormFactors, _),
    motherboard(Motherboard, FormFactor, _, _, _, _, _, _),
    member(FormFactor, SupportedFormFactors).

compatible_psu(PSU, _) :-
    psu(PSU, _, _, _).

compatible_storage_motherboard(Motherboard, Storage) :-
    motherboard(Motherboard, _, _, _, _, Ports, _, _),
    (ssd(Storage, _, Interface, _); hdd(Storage, _, Interface, _)),
    member(Interface, Ports).

compatible_monitor_gpu(Monitor, GPU) :-
    monitor(Monitor, _, _, _, _),
    gpu(GPU, _, _, _, _, _, _).
%----------------------------------------------------------------------------------------

% Выбор платы (материнской платы)
choose_motherboard(Components) :-
    write('Choose a Motherboard:'), nl,
    compatible_motherboards(Components, CompatibleMotherboards),
    components_price_filter(Components, CompatibleMotherboards, FilteredMotherboards),  % Фильтруем компоненты по цене
    write_list_with_info(FilteredMotherboards, 1),
    read(Index),
    nth1(Index, FilteredMotherboards, ChosenMotherboard),
    write('You chose: '), writeln(ChosenMotherboard),
    update_component(ChosenMotherboard, Components, motherboard, NewComponents),
    main_menu(NewComponents, _).


% Выбор процессора
choose_cpu(Components) :-
    write('Compatible CPU:'), nl,
    compatible_cpus(Components, CompatibleCPUs),
    components_price_filter(Components, CompatibleCPUs, FilteredCPUs),
    write_list_with_info(FilteredCPUs, 1),
    read(Index),
    nth1(Index, FilteredCPUs, ChosenCPU),
    write('You chose: '), writeln(ChosenCPU),
    update_component(ChosenCPU, Components, cpu, NewComponents),
    main_menu(NewComponents, _).


% Выбор видеокарты
choose_gpu(Components) :-
    write('Choose a GPU:'), nl,
    compatible_gpus(Components, CompatibleGPUs),
    components_price_filter(Components, CompatibleGPUs, FilteredGPUs),  % Фильтруем компоненты по цене
    write_list_with_info(FilteredGPUs, 1),
    read(Index),
    nth1(Index, FilteredGPUs, ChosenGPU),
    write('You chose: '), writeln(ChosenGPU),
    update_component(ChosenGPU, Components, gpu, NewComponents),
    main_menu(NewComponents, _).

% Выбор оперативной памяти
choose_ram(Components) :-
    write('Choose RAM:'), nl,
    compatible_ram(Components, CompatibleRAM),
    components_price_filter(Components, CompatibleRAM, FilteredRAM),  % Фильтруем компоненты по цене
    write_list_with_info(FilteredRAM, 1),
    read(Index),
    nth1(Index, FilteredRAM, ChosenRAM),
    write('You chose: '), writeln(ChosenRAM),
    update_component(ChosenRAM, Components, ram, NewComponents),
    main_menu(NewComponents, _).

% Выбор корпуса
choose_case(Components) :-
    write('Choose a Case:'), nl,
    compatible_case(Components, CompatibleCases),
    components_price_filter(Components, CompatibleCases, FilteredCases),  % Фильтруем компоненты по цене
    write_list_with_info(FilteredCases, 1),
    read(Index),
    nth1(Index, FilteredCases, ChosenCase),
    write('You chose: '), writeln(ChosenCase),
    update_component(ChosenCase, Components, case, NewComponents),
    main_menu(NewComponents, _).

% Выбор блока питания
choose_psu(Components) :-
    write('Choose a PSU:'), nl,
    % compatible_psu(Components, CompatiblePSUs),
    findall(PSU, psu(PSU, _, _, _), CompatiblePSUs),
    components_price_filter(Components, CompatiblePSUs, FilteredPSUs),  % Фильтруем компоненты по цене
    write_list_with_info(FilteredPSUs, 1),
    read(Index),
    nth1(Index, FilteredPSUs, ChosenPSU),
    write('You chose: '), writeln(ChosenPSU),
    update_component(ChosenPSU, Components, psu, NewComponents),
    main_menu(NewComponents, _).

% Выбор SSD
choose_ssd(Components) :-
    write('Choose an SSD:'), nl,
    compatible_storage(Components, ssd, CompatibleSSDs),
    components_price_filter(Components, CompatibleSSDs, FilteredSSDs),  % Фильтруем компоненты по цене
    write_list_with_info(FilteredSSDs, 1),
    read(Index),
    nth1(Index, FilteredSSDs, ChosenSSD),
    write('You chose: '), writeln(ChosenSSD),
    update_component(ChosenSSD, Components, ssd, NewComponents),
    main_menu(NewComponents, _).

% Выбор HDD
choose_hdd(Components) :-
    write('Choose an HDD:'), nl,
    compatible_storage(Components, hdd, CompatibleHDDs),
    components_price_filter(Components, CompatibleHDDs, FilteredHDDs),  % Фильтруем компоненты по цене
    write_list_with_info(FilteredHDDs, 1),
    read(Index),
    nth1(Index, FilteredHDDs, ChosenHDD),
    write('You chose: '), writeln(ChosenHDD),
    update_component(ChosenHDD, Components, hdd, NewComponents),
    main_menu(NewComponents, _).

% Выбор монитора
choose_monitor(Components) :-
    write('Choose a Monitor:'), nl,
    compatible_monitor(Components, CompatibleMonitors),
    components_price_filter(Components, CompatibleMonitors, FilteredMonitors),  % Фильтруем компоненты по цене
    write_list_with_info(FilteredMonitors, 1),
    read(Index),
    nth1(Index, FilteredMonitors, ChosenMonitor),
    write('You chose: '), writeln(ChosenMonitor),
    update_component(ChosenMonitor, Components, monitor, NewComponents),
    main_menu(NewComponents, _).

%----------------------------------------------------------------------------------------
% Подменю выбора накопителей
submenu_storage(Components) :-
    write('Choose Storage:'), nl,
    write('1. Choose SSD'), nl,
    write('2. Choose HDD'), nl,
    write('0. Go back'), nl,
    read(Choice),
    handle_storage_choice(Choice, Components).

handle_storage_choice(0, Components) :-
    main_menu(Components, _).

handle_storage_choice(1, Components) :-
    choose_ssd(Components).

handle_storage_choice(2, Components) :-
    choose_hdd(Components).

handle_storage_choice(_, Components) :-
    write('Invalid choice. Please try again.'), nl,
    submenu_storage(Components).

write_list_with_info([], _).
write_list_with_info([H|T], N) :-
    component_info(H, Info),
    format('~w. ~w: ~w~n', [N, H, Info]),
    NextN is N + 1,
    write_list_with_info(T, NextN).


remove_component_menu(Components) :-
    write('Choose an option:'), nl,
    write('1. Remove One Component'), nl,
    write('2. Remove All Components'), nl,
    write('0. Return to menu'), nl,
    read(Option),
    handle_remove_option(Option, Components, _).

handle_remove_option(1, Components, _) :-
    write('Choose a component to remove:'), nl,
    extract_component_models(Components, ComponentModels), % Извлекаем только модели компонентов
    write_list_with_info(ComponentModels, 1), % Передаем только модели компонентов
    read(Index),
    (   nth1(Index, Components, component(Type, _))
    ->  remove_component(Type, Components, NewComponents),
        main_menu(NewComponents, _)
    ;   writeln('Invalid choice.'),
        remove_component_menu(Components)
    ).



handle_remove_option(2, _, MaxPrice) :-
    writeln('All components have been removed.'),
    main_menu([], MaxPrice).

handle_remove_option(0, Components, _) :-
    main_menu(Components, _).

% Предикат для извлечения моделей компонентов
extract_component_models([], []).
extract_component_models([component(_, Model)|T], [Model|Rest]) :-
    extract_component_models(T, Rest).

%---------------------------------------------------------------------------------------------|
% Получение информации о компоненте
component_info(Model, Info) :-
    motherboard(Model, FormFactor, Socket, MemoryType, Slots, DiskDrivers, VideoPorts, Price),
    format(atom(Info), 'Price: ~w RUB, Form Factor: ~w, Socket: ~w, Memory Type: ~w, Slots: ~w, Disk Drivers: ~w, VideoPorts: ~w',
           [Price, FormFactor, Socket, MemoryType, Slots, DiskDrivers, VideoPorts]);
	cpu(Model, Frequency, Cores, Socket, IntegratedGPU, Price),
    format(atom(Info), 'Price: ~w RUB, , Frequency: ~w GHz, Cores: ~w, Socket: ~w, IntegratedGPU: ~w',
           [Price, Frequency, Cores, Socket, IntegratedGPU]);
    gpu(Model, GPUProcessor, GPUMemory, MemoryType, BusType, MemoryFrequency, Price),
    format(atom(Info), 'Price: ~w RUB, GPUProcessor: ~w, GPUMemory: ~w GB, MemoryType: ~w, BusType: ~w, MemoryFrequency: ~w MHz',
           [Price, GPUProcessor, GPUMemory, MemoryType, BusType, MemoryFrequency]);
	ram(Model, Size, MemoryType, Modules, Frequency, Price),
    format(atom(Info), 'Price: ~w RUB, Size: ~w GB, MemoryType: ~w, Modules: ~w, Frequency: ~w MHz',
           [Price, Size, MemoryType, Modules, Frequency]);
    case(Model, Material, SupportedFormFactors, Price),
    format(atom(Info), 'Price: ~w RUB, Material: ~w, SupportedFormFactors: ~w',
           [Price, Material, SupportedFormFactors]);
 	psu(Model, Power, EfficiencyRating, Price),
    format(atom(Info), 'Price: ~w RUB, Power: ~w W, EfficiencyRating: ~w',
           [Price, Power, EfficiencyRating]);
    ssd(Model, Capacity, Interface, Price),
    format(atom(Info), 'Price: ~w RUB, Capacity: ~w GB, Interface: ~w', 
           [Price, Capacity, Interface]);
    hdd(Model, Capacity, Interface, Price),
    format(atom(Info), 'Price: ~w RUB, Capacity: ~w GB, Interface: ~w', 
           [Price, Capacity, Interface]);
	monitor(Model, Resolution, PanelType, Port, Price),
    format(atom(Info), 'Price: ~w RUB, Resolution: ~w, PanelType: ~w, Port: ~w',
           [Price, Resolution, PanelType, Port]).
% Нахождение совместимых процессоров
compatible_cpus(Components, CompatibleCPUs) :-
    findall(CPU, (cpu(CPU, _, _, Socket, _, _),
                  (not(member(component(motherboard, _), Components));
                   (member(component(motherboard, MB), Components), motherboard(MB, _, Socket, _, _, _, _, _)))), CompatibleCPUs).

% Нахождение совместимых материнских плат
compatible_motherboards(Components, CompatibleMotherboards) :-
    findall(Motherboard, (
        motherboard(Motherboard, _, _, _, _, _, _, _),
        (not(member(component(cpu, _), Components));
         (member(component(cpu, CPU), Components), compatible_motherboard_cpu(Motherboard, CPU))),
        (not(member(component(ram, _), Components));
         (member(component(ram, RAM), Components), compatible_motherboard_ram(Motherboard, RAM))),
        (not(member(component(gpu, _), Components));
         (member(component(gpu, GPU), Components), compatible_motherboard_gpu(Motherboard, GPU))),
        (not(member(component(case, _), Components));
         (member(component(case, Case), Components), compatible_case_motherboard(Case, Motherboard))),
        (not(member(component(storage, _), Components));
         (member(component(storage, Storage), Components), compatible_storage_motherboard(Motherboard, Storage)))
    ), CompatibleMotherboards).

% Нахождение совместимых видеокарт
compatible_gpus(Components, CompatibleGPUs) :-
    findall(GPU, (
        gpu(GPU, _, _, _, _, _, _),
        (not(member(component(motherboard, _), Components));
         (member(component(motherboard, MB), Components), compatible_motherboard_gpu(MB, GPU))),
        (not(member(component(ram, _), Components));
         (member(component(ram, RAM), Components), compatible_ram_gpu(RAM, GPU))),
        (not(member(component(monitor, _), Components));
         (member(component(monitor, Monitor), Components), compatible_monitor_gpu(Monitor, GPU))),
        (not(member(component(psu, _), Components));
         (member(component(psu, PSU), Components), compatible_psu(PSU, [component(gpu, GPU) | Components])))
    ), CompatibleGPUs).


% Определение совместимой оперативной памяти с учетом слотов
compatible_ram(Components, CompatibleRAM) :-
    findall(RAM, (
        ram(RAM, _, MemoryType, Modules, _, _),
        % Проверка совместимости с материнской платой
        (not(member(component(motherboard, _), Components));
         (member(component(motherboard, MB), Components), 
          motherboard(MB, _, _, MemoryType, Slots, _, _, _),
          Modules =< Slots)),
        % Проверка совместимости с видеокартой (если требуется)
        (not(member(component(gpu, _), Components));
         (member(component(gpu, GPU), Components), 
          gpu(GPU, _, _, MemoryType, _, _, _))),
        % Исключение уже выбранных модулей оперативной памяти
        \+ member(component(ram, RAM), Components)
    ), CompatibleRAM).

% Определение совместимости корпуса и материнской платы
compatible_case(Components, CompatibleCases) :-
    findall(Case, (
        case(Case, _, SupportedFormFactors, _),
        % Проверка совместимости с материнской платой
        (not(member(component(motherboard, _), Components));
         (member(component(motherboard, MB), Components), 
          motherboard(MB, FormFactor, _, _, _, _, _, _),
          member(FormFactor, SupportedFormFactors))),
        % Исключение уже выбранных корпусов
        \+ member(component(case, Case), Components)
    ), CompatibleCases).

% Определение совместимости диска с материнской платой
compatible_storage(Components, Type, CompatibleStorage) :-
    findall(Storage, (
        (Type == ssd -> ssd(Storage, _, Interface, _); hdd(Storage, _, Interface, _)),
        % Проверка совместимости с материнской платой
        (not(member(component(motherboard, _), Components));
         (member(component(motherboard, MB), Components), 
          motherboard(MB, _, _, _, _, SupportedInterfaces, _, _),
          member(Interface, SupportedInterfaces))),
        % Исключение уже выбранных дисков
        \+ member(component(Type, Storage), Components)
    ), CompatibleStorage).

% Проверка совместимости порта монитора и материнской платы
compatible_monitor(Components, CompatibleMonitors) :-
    findall(Monitor, (
        monitor(Monitor, _, _, MonitorPort, _),
        % Проверка совместимости с материнской платой
        (not(member(component(motherboard, _), Components));
         (member(component(motherboard, MB), Components), 
          motherboard(MB, _, _, _, _, _, Ports, _),
          member(MonitorPort, Ports))),
        % Исключение уже выбранных мониторов
        \+ member(component(monitor, Monitor), Components)
    ), CompatibleMonitors).

%---------------------------Предикат для фильтрации компонентов по максимальной цене----------------------------|
components_price_filter(CurrentComponents, Components, FilteredComponents) :-

    (max_price(MaxPrice) -> true; MaxPrice = 0),  % Получаем максимальную цену сборки или устанавливаем 0, если не задано
    total_price(CurrentComponents, CurrentPrice),  % Рассчитываем текущую стоимость выбранных компонентов
    RemainingBudget is MaxPrice - CurrentPrice,  % Рассчитываем оставшийся бюджет
    (MaxPrice =:= 0 ->  % Проверяем, равна ли максимальная цена нулю
        FilteredComponents = Components  % Если да, не применяем фильтр
    ;  % Иначе применяем фильтр
        include(within_price_limit(RemainingBudget), Components, FilteredComponents)
    ).

% Предикат для проверки, находится ли цена компонента в пределах максимальной цены
within_price_limit( MaxPrice, Component) :-
    component_price(Component, Price),
    Price =< MaxPrice.