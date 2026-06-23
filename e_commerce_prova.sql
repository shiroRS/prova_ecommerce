create schema prova_Ecommerce character set utf8mb4 collate utf8mb4_general_ci;

use prova_Ecommerce;


create table clientes (
	id_cliente int primary key auto_increment,
    gmail varchar (100),
    nome varchar (100),
    telefone varchar (100),
    cep varchar (100)
    );
    
create table produtos (
	id_produto int primary key auto_increment,
    nome varchar(100),
    preco float
    );
    
create table saidas (
	id_vendas int auto_increment primary key,
    data_venda date,
	id_cliente int,
    id_produto int,
    Foreign key (id_cliente) references clientes(id_cliente),
	Foreign key (id_produto) references produtos(id_produto)
    );
    
insert into clientes (gmail, nome, telefone, cep)
values
	("kawansakiyama@gmail.com","kawan",11963476989,19298123),
    ("kauelima@gmail.com","kaue",11854674545,12145345),
    ("joaosilva@gmail.com","joao",11675438945,12343694),
    ("davidcleber@gmail.com","david",11234526740,93478412),
    ("eduardohenrique@gmail.com","eduardo",11637293438,04793234);
    
insert into produtos( nome, preco )
values
	("iphone 15",4000),
    ("edge 45", 2900),
    ("iphone 16e", 3500),
    ("Zflip",3800),
    ("iphone 12",2500);

insert into saidas (id_cliente, id_produto, data_venda)
values
	(1,4,"2026/07/23"),
    (3,1,"2026/07/22"),
    (2,2,"2026/07/22"),
    (2,3,"2026/07/21"),
    (4,3,"2026/07/21");
    
select * from produtos
where preco>3500;


select count(*) from saidas where data_venda="2026/07/21";


create view celulares as
	select id_produto, nome
    from produtos
    where preco>3500;
    
select * from celulares;

alter table produtos add column estoque int default 100;


create index func_preco on produtos(preco);

delimiter //
	create procedure pd_aumento (in p_nome varchar (100), in percentual int)
    begin
		update produtos
        set preco=preco*(1+(percentual/100))
        where nome=p_nome;
end;
 // delimiter ;
 
 call pd_aumento ("iphone 15",10);
 
delimiter //
create trigger baixas_estoque 
after insert on saidas
for each row 
begin 
	update produtos
	set estoque = estoque - 1
	where id_produto = new.id_produto;
end;
//
delimiter ;

insert into saidas (id_produto, id_cliente, data_venda) 
values (3, 1, "2026-07-22");
    



	
    
    
    
