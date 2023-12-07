--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.0
-- Dumped by pg_dump version 9.4.0
-- Started on 2015-04-23 01:23:05

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 195 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2179 (class 0 OID 0)
-- Dependencies: 195
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 183 (class 1259 OID 65799)
-- Name: bono; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bono (
    cod_abono integer NOT NULL,
    cedula_cliente character varying(15),
    saldo_abono double precision,
    fecha date,
    estado character varying(1)
);


ALTER TABLE bono OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 65802)
-- Name: abono_cod_abono_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE abono_cod_abono_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abono_cod_abono_seq OWNER TO postgres;

--
-- TOC entry 2180 (class 0 OID 0)
-- Dependencies: 184
-- Name: abono_cod_abono_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE abono_cod_abono_seq OWNED BY bono.cod_abono;


--
-- TOC entry 181 (class 1259 OID 65704)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cliente (
    cedula_cliente character varying(15) NOT NULL,
    nombres character(50),
    apellidos character(50),
    direccion character varying(50),
    telefono character varying(15)
);


ALTER TABLE cliente OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 65854)
-- Name: consecutivo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE consecutivo (
    id_consecutivo integer NOT NULL,
    inicio integer,
    actual integer,
    detalle character varying(50)
);


ALTER TABLE consecutivo OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 65770)
-- Name: cuentas_cobrar; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cuentas_cobrar (
    numero_factura integer NOT NULL,
    cedula_cliente character varying(15),
    estado character varying(1),
    saldo_pendiente double precision,
    detalle text
);


ALTER TABLE cuentas_cobrar OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 65678)
-- Name: empleado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE empleado (
    cedula_empleado character varying(15) NOT NULL,
    nombre character varying(100),
    clave_acceso character varying(10)
);


ALTER TABLE empleado OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 74170)
-- Name: factura_devolucion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE factura_devolucion (
    cod_devolucion integer NOT NULL,
    numero_factura integer,
    fecha_devolucion date,
    hora_devolucion time without time zone,
    cedula_empleado character varying(15)
);


ALTER TABLE factura_devolucion OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 74168)
-- Name: factura_devolucion_cod_devolucion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE factura_devolucion_cod_devolucion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE factura_devolucion_cod_devolucion_seq OWNER TO postgres;

--
-- TOC entry 2181 (class 0 OID 0)
-- Dependencies: 193
-- Name: factura_devolucion_cod_devolucion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE factura_devolucion_cod_devolucion_seq OWNED BY factura_devolucion.cod_devolucion;


--
-- TOC entry 187 (class 1259 OID 65896)
-- Name: factura_venta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE factura_venta (
    numero_factura integer NOT NULL,
    fecha_factura date,
    hora_factura time without time zone,
    cedula_empleado character varying(15)
);


ALTER TABLE factura_venta OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 65629)
-- Name: inventario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE inventario (
    cod_producto integer NOT NULL,
    nombre_producto character varying(100) NOT NULL,
    concentracion character varying(50),
    presentacion character varying(50),
    iva double precision NOT NULL,
    costo_unitario double precision NOT NULL,
    precio_unitario double precision NOT NULL,
    estado character varying(1),
    existencias integer
);


ALTER TABLE inventario OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 65627)
-- Name: inventario1_cod_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE inventario1_cod_producto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE inventario1_cod_producto_seq OWNER TO postgres;

--
-- TOC entry 2182 (class 0 OID 0)
-- Dependencies: 175
-- Name: inventario1_cod_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE inventario1_cod_producto_seq OWNED BY inventario.cod_producto;


--
-- TOC entry 179 (class 1259 OID 65660)
-- Name: kardex_entrada; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE kardex_entrada (
    cod_entrada integer NOT NULL,
    cod_tipo_transaccion integer,
    cod_producto integer,
    fecha_transaccion date,
    hora_transaccion time without time zone,
    fecha_vencimiento date,
    cantidad integer,
    cedula_empleado character varying(15),
    detalle text,
    total_costo double precision,
    total_precio double precision,
    numero_factura character varying(20),
    cod_laboratorio integer,
    nit_proveedor character varying(15)
);


ALTER TABLE kardex_entrada OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 65658)
-- Name: kardex_cod_transaccion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE kardex_cod_transaccion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE kardex_cod_transaccion_seq OWNER TO postgres;

--
-- TOC entry 2183 (class 0 OID 0)
-- Dependencies: 178
-- Name: kardex_cod_transaccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE kardex_cod_transaccion_seq OWNED BY kardex_entrada.cod_entrada;


--
-- TOC entry 192 (class 1259 OID 74163)
-- Name: kardex_devolucion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE kardex_devolucion (
    cod_item_devolucion integer NOT NULL,
    cod_devolucion integer,
    cod_producto integer,
    cantidad integer,
    total_costo double precision,
    total_precio double precision
);


ALTER TABLE kardex_devolucion OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 74161)
-- Name: kardex_devolucion_cod_item_devolucion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE kardex_devolucion_cod_item_devolucion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE kardex_devolucion_cod_item_devolucion_seq OWNER TO postgres;

--
-- TOC entry 2184 (class 0 OID 0)
-- Dependencies: 191
-- Name: kardex_devolucion_cod_item_devolucion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE kardex_devolucion_cod_item_devolucion_seq OWNED BY kardex_devolucion.cod_item_devolucion;


--
-- TOC entry 190 (class 1259 OID 66023)
-- Name: kardex_entrada_historico; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE kardex_entrada_historico (
    cod_entrada integer NOT NULL,
    cod_tipo_transaccion integer,
    cod_producto integer,
    fecha_transaccion date,
    hora_transaccion time without time zone,
    fecha_vencimiento date,
    cantidad integer,
    cedula_empleado character varying(15),
    detalle text,
    total_costo double precision,
    total_precio double precision,
    numero_factura character varying(20),
    cod_laboratorio integer,
    nit_proveedor character varying(15)
);


ALTER TABLE kardex_entrada_historico OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 65939)
-- Name: kardex_salida; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE kardex_salida (
    cod_salida integer NOT NULL,
    cod_tipo_transaccion integer,
    cod_producto integer,
    fecha_salida date,
    hora_salida time without time zone,
    cantidad integer,
    cedula_empleado character varying(15),
    detalle text,
    total_costo double precision,
    total_precio double precision
);


ALTER TABLE kardex_salida OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 65937)
-- Name: kardex_salida_cod_salida_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE kardex_salida_cod_salida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE kardex_salida_cod_salida_seq OWNER TO postgres;

--
-- TOC entry 2185 (class 0 OID 0)
-- Dependencies: 188
-- Name: kardex_salida_cod_salida_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE kardex_salida_cod_salida_seq OWNED BY kardex_salida.cod_salida;


--
-- TOC entry 186 (class 1259 OID 65859)
-- Name: kardex_venta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE kardex_venta (
    cod_venta integer DEFAULT nextval('kardex_cod_transaccion_seq'::regclass) NOT NULL,
    numero_factura integer,
    cod_tipo_transaccion integer,
    cod_producto integer,
    cantidad integer,
    total_costo double precision,
    total_precio double precision
);


ALTER TABLE kardex_venta OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 65610)
-- Name: laboratorio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE laboratorio (
    cod_laboratorio integer NOT NULL,
    nombre_laboratorio character varying(100)
);


ALTER TABLE laboratorio OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 65613)
-- Name: laboratorio_cod_laboratorio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE laboratorio_cod_laboratorio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE laboratorio_cod_laboratorio_seq OWNER TO postgres;

--
-- TOC entry 2186 (class 0 OID 0)
-- Dependencies: 174
-- Name: laboratorio_cod_laboratorio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE laboratorio_cod_laboratorio_seq OWNED BY laboratorio.cod_laboratorio;


--
-- TOC entry 172 (class 1259 OID 65605)
-- Name: proveedor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE proveedor (
    nit_proveedor character varying(15) NOT NULL,
    nombre_proveedor character varying(100),
    direccion character varying(20),
    ciudad character varying(50),
    reguimen character varying(15)
);


ALTER TABLE proveedor OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 65653)
-- Name: tipo_transaccion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_transaccion (
    cod_tipo_transaccion integer NOT NULL,
    detalle character varying(100)
);


ALTER TABLE tipo_transaccion OWNER TO postgres;

--
-- TOC entry 1962 (class 2604 OID 65804)
-- Name: cod_abono; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bono ALTER COLUMN cod_abono SET DEFAULT nextval('abono_cod_abono_seq'::regclass);


--
-- TOC entry 1966 (class 2604 OID 74173)
-- Name: cod_devolucion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura_devolucion ALTER COLUMN cod_devolucion SET DEFAULT nextval('factura_devolucion_cod_devolucion_seq'::regclass);


--
-- TOC entry 1960 (class 2604 OID 65632)
-- Name: cod_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventario ALTER COLUMN cod_producto SET DEFAULT nextval('inventario1_cod_producto_seq'::regclass);


--
-- TOC entry 1965 (class 2604 OID 74166)
-- Name: cod_item_devolucion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_devolucion ALTER COLUMN cod_item_devolucion SET DEFAULT nextval('kardex_devolucion_cod_item_devolucion_seq'::regclass);


--
-- TOC entry 1961 (class 2604 OID 65663)
-- Name: cod_entrada; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_entrada ALTER COLUMN cod_entrada SET DEFAULT nextval('kardex_cod_transaccion_seq'::regclass);


--
-- TOC entry 1964 (class 2604 OID 65942)
-- Name: cod_salida; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_salida ALTER COLUMN cod_salida SET DEFAULT nextval('kardex_salida_cod_salida_seq'::regclass);


--
-- TOC entry 1959 (class 2604 OID 65615)
-- Name: cod_laboratorio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY laboratorio ALTER COLUMN cod_laboratorio SET DEFAULT nextval('laboratorio_cod_laboratorio_seq'::regclass);


--
-- TOC entry 2187 (class 0 OID 0)
-- Dependencies: 184
-- Name: abono_cod_abono_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('abono_cod_abono_seq', 1, false);


--
-- TOC entry 2160 (class 0 OID 65799)
-- Dependencies: 183
-- Data for Name: bono; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY bono (cod_abono, cedula_cliente, saldo_abono, fecha, estado) FROM stdin;
\.


--
-- TOC entry 2158 (class 0 OID 65704)
-- Dependencies: 181
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cliente (cedula_cliente, nombres, apellidos, direccion, telefono) FROM stdin;
1085498977	Rider Alexander                                   	Suarez Alfaro                                     	Ospina-Cuadquiran	3136822236
1086498977	carlos german                                     	chaucanes Montenegro                              	catambuco	3188770650
1086498978	jose vicente                                      	araujo estrada                                    	botanilla	314567890
1081999999	jenny driana                                      	zambrano                                          	sector central	318890998
108649897	kkjkfjsdkf                                        	vxmcnvmxnvmxc                                     		
10865865	jenny                                             	xambrano                                          	ospina sector central	3136822236
10864989776	jose                                              	portillo                                          	quadquiran ospina	3137883445
10864989	jose veo                                          	ramos la torree                                   	san isidro	313456789
9450270	Aura Cecilia                                      	Montenegro Erazo                                  	barrio amistad	3155601114
1086498975	justiniano                                        	chaucanes MOntenegro                              	calle 13	3155601114
1086498	JOSE                                              	VICENTE                                           	VEREDA NARIÑO	3136822236
\.


--
-- TOC entry 2162 (class 0 OID 65854)
-- Dependencies: 185
-- Data for Name: consecutivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY consecutivo (id_consecutivo, inicio, actual, detalle) FROM stdin;
1	100	167	Consecutivo Facturacion ventas
\.


--
-- TOC entry 2159 (class 0 OID 65770)
-- Dependencies: 182
-- Data for Name: cuentas_cobrar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cuentas_cobrar (numero_factura, cedula_cliente, estado, saldo_pendiente, detalle) FROM stdin;
150	1086498977	A	41400	,mncvnvm<nvmznv
163	1086498977	A	0	fiado al joven herman
134	1086498977	A	92800	fiado al joven carlos
135	10864989	A	105600	fiado al joven carlos
136	1086498977	A	36000	fiado al joven karlitos german
137	1086498977	A	110400	carlitos
138	1086498977	A	201800	carlos german chaucanes 
142	1085498977	A	26000	hjkhkj
144	1086498977	A	100000	
147	1086498977	A	30000	
148	1085498977	A	13200	toco fiarle al joven rider
149	1086498977	A	122000	dfsdfs
152	1086498977	A	26400	se le fiara solo por tres dias
153	1086498977	A	72000	jjkljljl
155	1086498977	A	120000	carlos german chaucanes
157	1086498977	A	15000	
159	1086498977	A	5000	venta de prir
160	1086498977	A	51400	ESTA VENTA SE LLEVO A EFECTO Y SE LA FIO AL JOVEN CARLOS
164	10864989776	A	65000	cuenta fiada
166	1085498977	A	37000	ndskd z,mfn<lfd dxfn<df ,dfn<fdn nf<sdf z<d,mfn<.,df mn<slfn f<,.mfn<ñ f.,.fb.zmd,f <,.fb.z<, f<.,fbz<,.fb .bf<,zdf  z<kjfb<z,.nf <z.,fb<zf <z.fb<zkfz< ,f <z,mmnf f,<zfkjefoeoNNFJSDF DFF KSDNFAJBFKDBFSFBSDSDBFFBSALKJFHSKFHSDKJJSBFSBFBSFJSFSJFBS HDSFHJ FAJD AKJFSJ SAJFAJF FBYEW KJFAKSSF SJFAK SDFBAKJF JSFBJA SJFBJSFBJF
167	1086498	A	25000	FIANDA AL JOVEN JOSE
\.


--
-- TOC entry 2157 (class 0 OID 65678)
-- Dependencies: 180
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY empleado (cedula_empleado, nombre, clave_acceso) FROM stdin;
1086498971	Efrain delgado	123
1082498972	Alicia Ipiales	123
1086498977	Cecilia Montenegro	123
\.


--
-- TOC entry 2171 (class 0 OID 74170)
-- Dependencies: 194
-- Data for Name: factura_devolucion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY factura_devolucion (cod_devolucion, numero_factura, fecha_devolucion, hora_devolucion, cedula_empleado) FROM stdin;
1	133	2015-04-22	19:21:32.53	1086498977
2	150	2015-04-22	22:59:10.418	1086498977
3	163	2015-04-23	00:42:15.681	1086498977
4	162	2015-04-23	01:05:24.364	1086498977
5	162	2015-04-23	01:05:59.675	1086498977
6	163	2015-04-23	01:09:15.281	1086498977
\.


--
-- TOC entry 2188 (class 0 OID 0)
-- Dependencies: 193
-- Name: factura_devolucion_cod_devolucion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('factura_devolucion_cod_devolucion_seq', 6, true);


--
-- TOC entry 2164 (class 0 OID 65896)
-- Dependencies: 187
-- Data for Name: factura_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY factura_venta (numero_factura, fecha_factura, hora_factura, cedula_empleado) FROM stdin;
162	2015-04-20	22:49:51.003	1086498977
163	2015-04-20	22:51:30.881	1082498972
164	2015-04-21	12:45:41.807	1086498977
165	2015-04-21	12:47:10.127	1086498977
133	2015-04-17	16:07:54.65	1086498971
134	2015-04-17	16:09:29.344	1086498971
135	2015-04-17	16:17:22.141	1086498971
136	2015-04-17	16:19:35.102	1086498971
137	2015-04-17	21:58:55.51	1086498971
138	2015-04-17	22:30:25.204	1086498971
139	2015-04-17	22:32:41.87	1086498971
140	2015-04-17	22:35:06.224	1086498971
141	2015-04-17	22:38:18.539	1086498971
142	2015-04-17	22:41:51.524	1086498971
143	2015-04-17	22:44:15.071	1086498971
144	2015-04-17	22:53:12.537	1086498971
145	2015-04-17	22:55:59.879	1086498971
146	2015-04-17	23:06:34.561	1086498971
147	2015-04-17	23:08:04.592	1086498971
148	2015-04-18	00:45:08.85	1086498971
149	2015-04-18	15:53:09.476	1086498971
150	2015-04-18	17:52:25.391	1086498971
151	2015-04-18	20:00:06.065	1086498971
152	2015-04-18	20:02:12.652	1086498971
166	2015-04-21	12:51:35.814	1086498977
167	2015-04-21	12:56:35.747	1086498977
153	2015-04-18	20:59:53.09	1086498971
154	2015-04-18	21:10:54.976	1086498971
155	2015-04-18	21:13:28.534	1086498971
156	2015-04-18	21:16:14.815	1086498971
157	2015-04-18	21:24:18.418	1086498971
158	2015-04-18	21:25:04.186	1086498971
159	2015-04-19	16:17:41.172	1086498971
160	2015-04-20	20:25:48.115	1086498971
161	2015-04-20	21:12:40.563	1086498971
\.


--
-- TOC entry 2153 (class 0 OID 65629)
-- Dependencies: 176
-- Data for Name: inventario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY inventario (cod_producto, nombre_producto, concentracion, presentacion, iva, costo_unitario, precio_unitario, estado, existencias) FROM stdin;
47	ujtytutyutyu	tyutyututyutyu	tutyuttutyutyutu	0	0	0	A	2
45	acetato de metil	34ml	frasco	16	3400	6000	A	1
46	furadan	23mg	frasco	16	10000	13000	A	5
44	abonos M45	34 arobas	cajas	16	12400	13200	A	50
43	curaxil	15mg	capsulas	15	3500	5000	A	32
\.


--
-- TOC entry 2189 (class 0 OID 0)
-- Dependencies: 175
-- Name: inventario1_cod_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('inventario1_cod_producto_seq', 47, true);


--
-- TOC entry 2190 (class 0 OID 0)
-- Dependencies: 178
-- Name: kardex_cod_transaccion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('kardex_cod_transaccion_seq', 209, true);


--
-- TOC entry 2169 (class 0 OID 74163)
-- Dependencies: 192
-- Data for Name: kardex_devolucion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY kardex_devolucion (cod_item_devolucion, cod_devolucion, cod_producto, cantidad, total_costo, total_precio) FROM stdin;
1	1	44	6	74400	79200
2	1	46	5	50000	65000
3	2	44	2	24800	26400
4	2	43	3	10500	15000
5	3	44	3	37200	39600
6	3	43	2	7000	10000
7	4	44	1	12400	13200
8	4	43	2	7000	10000
9	5	44	2	24800	26400
10	5	43	1	3500	5000
11	6	44	3	37200	39600
12	6	43	2	7000	10000
\.


--
-- TOC entry 2191 (class 0 OID 0)
-- Dependencies: 191
-- Name: kardex_devolucion_cod_item_devolucion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('kardex_devolucion_cod_item_devolucion_seq', 12, true);


--
-- TOC entry 2156 (class 0 OID 65660)
-- Dependencies: 179
-- Data for Name: kardex_entrada; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY kardex_entrada (cod_entrada, cod_tipo_transaccion, cod_producto, fecha_transaccion, hora_transaccion, fecha_vencimiento, cantidad, cedula_empleado, detalle, total_costo, total_precio, numero_factura, cod_laboratorio, nit_proveedor) FROM stdin;
191	100	44	2015-04-19	16:31:08.56	2015-06-13	3	1086498971	kdjfñslkdklfsdf	37200	39600	345	3	1081498977
192	100	43	2015-04-19	21:14:39.617	2015-06-20	56	1086498971	sdasdazx\r\nczxcm<zxcbc\r\nzxcnzc<nc.,zmc\r\nc<ncmnz<,cn<z.c,\r\nzxc,,<zc,zc,z\r\nzc,,z<cm<z,.cmz.c\r\nzc,,m<z,cmzx.c\r\nzc,mzc,zmc.\r\nzc,,mz,c.mz.c\r\nzczcmz,cmz.	196000	280000	234	4	1082450998
193	100	44	2015-04-19	21:15:13.142	2015-06-20	1	1086498971	sdasdazx\r\nczxcm<zxcbc\r\nzxcnzc<nc.,zmc\r\nc<ncmnz<,cn<z.c,\r\nzxc,,<zc,zc,z\r\nzc,,z<cm<z,.cmz.c\r\nzc,,m<z,cmzx.c\r\nzc,mzc,zmc.\r\nzc,,mz,c.mz.c\r\nzczcmz,cmz.	12400	13200	234	4	1082450998
194	100	44	2015-04-19	21:15:30.437	2015-06-20	55	1086498971	sdasdazx\r\nczxcm<zxcbc\r\nzxcnzc<nc.,zmc\r\nc<ncmnz<,cn<z.c,\r\nzxc,,<zc,zc,z\r\nzc,,z<cm<z,.cmz.c\r\nzc,,m<z,cmzx.c\r\nzc,mzc,zmc.\r\nzc,,mz,c.mz.c\r\nzczcmz,cmz.	682000	726000	234	4	1082450998
198	100	47	2015-04-20	21:29:53.97	2015-06-20	2	1086498977	dfgdgjhfhj	0	0	678	4	1082450998
199	100	45	2015-04-20	21:34:36.37	2015-08-01	5	1086498977	karlitos	17000	30000	45	3	1082450998
200	100	46	2015-04-20	21:37:33.83	2015-06-27	6	1082498972	carlos	60000	78000	349	2	1082450998
\.


--
-- TOC entry 2167 (class 0 OID 66023)
-- Dependencies: 190
-- Data for Name: kardex_entrada_historico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY kardex_entrada_historico (cod_entrada, cod_tipo_transaccion, cod_producto, fecha_transaccion, hora_transaccion, fecha_vencimiento, cantidad, cedula_empleado, detalle, total_costo, total_precio, numero_factura, cod_laboratorio, nit_proveedor) FROM stdin;
156	100	44	2015-04-18	13:48:20.237	2015-08-08	4	1086498971	carlos german chaucanes	49600	52800	230	4	1086498977
157	100	43	2015-04-18	14:05:55.872	2016-03-05	7	1086498971	cnanczxmcz,c	24500	35000	234	4	1086498977
158	100	45	2015-04-18	14:06:58.694	2016-05-10	9	1086498971	llegaon del señor carlos	30600	54000	111	2	1081498977
159	100	45	2015-04-18	14:07:12.451	2016-05-10	10	1086498971	llegaon del señor carlos	34000	60000	111	2	1081498977
160	100	44	2015-04-18	14:12:25.428	2016-05-10	9	1086498971	llegaon del señor carlos	111600	118800	111	2	1081498977
161	100	46	2015-04-18	14:58:44.247	2015-10-17	9	1086498971	kjhlk vgvgvgghcgf gvf	90000	117000	3456	2	1081498977
162	100	45	2015-04-18	15:00:39.468	2015-06-19	7	1086498971	jenyy zambrano vino a dejar	23800	42000	343	3	1082450998
167	100	46	2015-04-18	17:53:06.733	2015-09-19	7	1086498971	hgsnsdgn	70000	91000	4545	3	1082450998
183	100	45	2015-04-18	21:12:32.858	2015-09-19	20	1086498971	bfsdfjsd dfbsjbdfds	68000	120000	2345	3	1086498977
186	100	43	2015-04-18	21:23:32.495	2015-06-13	6	1086498971	carlos german chaucanes	21000	30000	345	4	1086498977
190	100	45	2015-04-19	16:30:41.053	2015-06-13	4	1086498971	kdjfñslkdklfsdf	13600	24000	345	3	1081498977
191	100	44	2015-04-19	16:31:08.56	2015-06-13	3	1086498971	kdjfñslkdklfsdf	37200	39600	345	3	1081498977
192	100	43	2015-04-19	21:14:39.617	2015-06-20	56	1086498971	sdasdazx\r\nczxcm<zxcbc\r\nzxcnzc<nc.,zmc\r\nc<ncmnz<,cn<z.c,\r\nzxc,,<zc,zc,z\r\nzc,,z<cm<z,.cmz.c\r\nzc,,m<z,cmzx.c\r\nzc,mzc,zmc.\r\nzc,,mz,c.mz.c\r\nzczcmz,cmz.	196000	280000	234	4	1082450998
193	100	44	2015-04-19	21:15:13.142	2015-06-20	1	1086498971	sdasdazx\r\nczxcm<zxcbc\r\nzxcnzc<nc.,zmc\r\nc<ncmnz<,cn<z.c,\r\nzxc,,<zc,zc,z\r\nzc,,z<cm<z,.cmz.c\r\nzc,,m<z,cmzx.c\r\nzc,mzc,zmc.\r\nzc,,mz,c.mz.c\r\nzczcmz,cmz.	12400	13200	234	4	1082450998
194	100	44	2015-04-19	21:15:30.437	2015-06-20	55	1086498971	sdasdazx\r\nczxcm<zxcbc\r\nzxcnzc<nc.,zmc\r\nc<ncmnz<,cn<z.c,\r\nzxc,,<zc,zc,z\r\nzc,,z<cm<z,.cmz.c\r\nzc,,m<z,cmzx.c\r\nzc,mzc,zmc.\r\nzc,,mz,c.mz.c\r\nzczcmz,cmz.	682000	726000	234	4	1082450998
198	100	47	2015-04-20	21:29:53.97	2015-06-20	2	1086498971	dfgdgjhfhj	0	0	678	4	1082450998
199	100	45	2015-04-20	21:34:36.37	2015-08-01	5	1086498971	karlitos	17000	30000	45	3	1082450998
200	100	46	2015-04-20	21:37:33.83	2015-06-27	6	1086498971	carlos	60000	78000	349	2	1082450998
\.


--
-- TOC entry 2166 (class 0 OID 65939)
-- Dependencies: 189
-- Data for Name: kardex_salida; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY kardex_salida (cod_salida, cod_tipo_transaccion, cod_producto, fecha_salida, hora_salida, cantidad, cedula_empleado, detalle, total_costo, total_precio) FROM stdin;
1	101	45	2015-04-19	20:49:42.956	2	1086498977	estas 2 unidades salesn por vencimiento	6800	12000
2	101	44	2015-04-19	20:52:19.249	1	1086498977	kjsalkjf sdkflskadfn sdfnasdlfn sdfnsafdn sdfsdf fnasdfn sdfnasdfn	12400	13200
3	101	45	2015-04-19	20:59:11.9	2	1086498977	salieron por vencidas	6800	12000
4	101	45	2015-04-19	20:59:22.936	2	1086498977	salieron por vencidas	6800	12000
5	101	45	2015-04-19	20:59:30.684	2	1086498977	salieron por vencidas	6800	12000
6	101	44	2015-04-19	21:08:43.288	2	1086498977	dasd	24800	26400
7	101	43	2015-04-19	21:22:02.805	6	1086498977	cgdfxdggdgds	21000	30000
8	101	44	2015-04-19	21:22:39.16	1	1086498977	ghdghdh	12400	13200
9	101	43	2015-04-19	21:24:40.02	4	1086498977	carlos german chaucanes\r\nlkf<df dfnlf	14000	20000
10	101	45	2015-04-20	22:18:37.374	2	1082498972	se vencieron esos productos	6800	12000
\.


--
-- TOC entry 2192 (class 0 OID 0)
-- Dependencies: 188
-- Name: kardex_salida_cod_salida_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('kardex_salida_cod_salida_seq', 10, true);


--
-- TOC entry 2163 (class 0 OID 65859)
-- Dependencies: 186
-- Data for Name: kardex_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY kardex_venta (cod_venta, numero_factura, cod_tipo_transaccion, cod_producto, cantidad, total_costo, total_precio) FROM stdin;
127	134	103	43	8	28000	40000
128	134	103	44	4	49600	52800
129	135	103	44	8	99200	105600
130	136	103	45	6	20400	36000
131	137	103	44	7	86800	92400
132	137	103	45	3	10200	18000
133	138	103	44	9	111600	118800
134	138	103	45	2	6800	12000
135	138	103	43	9	31500	45000
136	138	103	46	2	20000	26000
137	139	102	45	1	3400	6000
138	139	102	43	80	280000	400000
139	139	102	46	25	250000	325000
140	140	102	43	2	7000	10000
141	141	102	44	9	111600	118800
142	141	102	43	1	3500	5000
143	142	103	46	2	20000	26000
144	143	102	44	2	24800	26400
146	144	103	43	20	70000	100000
147	145	102	43	1	3500	5000
148	146	102	44	1	12400	13200
149	146	102	43	2	7000	10000
150	147	103	43	6	21000	30000
151	148	103	44	1	12400	13200
163	149	103	46	9	90000	117000
164	149	103	43	1	3500	5000
168	151	102	46	7	70000	91000
169	151	102	45	5	17000	30000
170	152	103	44	2	24800	26400
205	164	103	46	5	50000	65000
206	165	102	44	5	62000	66000
207	166	103	43	5	17500	25000
208	166	103	45	2	6800	12000
209	167	103	43	5	17500	25000
125	133	102	44	6	74400	79200
181	153	103	45	12	40800	72000
182	154	102	43	2	7000	10000
184	155	103	45	20	68000	120000
185	156	102	44	3	37200	39600
187	157	103	43	3	10500	15000
188	158	102	43	2	7000	10000
189	159	103	43	1	3500	5000
195	160	103	44	2	24800	26400
196	160	103	43	5	17500	25000
197	161	102	44	4	49600	52800
126	133	102	46	5	50000	65000
165	150	103	44	2	24800	26400
166	150	103	43	3	10500	15000
201	162	102	44	0	0	0
202	162	102	43	0	0	0
203	163	103	44	0	0	0
204	163	103	43	0	0	0
\.


--
-- TOC entry 2150 (class 0 OID 65610)
-- Dependencies: 173
-- Data for Name: laboratorio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY laboratorio (cod_laboratorio, nombre_laboratorio) FROM stdin;
1	Genfar
2	Ospinquimica
3	Agroquimicos
4	Tecnoquimicas
\.


--
-- TOC entry 2193 (class 0 OID 0)
-- Dependencies: 174
-- Name: laboratorio_cod_laboratorio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('laboratorio_cod_laboratorio_seq', 4, true);


--
-- TOC entry 2149 (class 0 OID 65605)
-- Dependencies: 172
-- Data for Name: proveedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY proveedor (nit_proveedor, nombre_proveedor, direccion, ciudad, reguimen) FROM stdin;
1081498977	AgroGanadero	Calle 13 No 20-40 Pa	Pasto	Comun
1082450998	La Sabanera	Calle 30 No 30-70	Ipiales	Simplificado
1086498977	Agro el Manzano	vereda el Manzano	Ospina	Gran contribuye
\.


--
-- TOC entry 2154 (class 0 OID 65653)
-- Dependencies: 177
-- Data for Name: tipo_transaccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_transaccion (cod_tipo_transaccion, detalle) FROM stdin;
100	Entrada productos
103	Salida Cuenta por Cobrar
101	Salida Productos
102	Salida por venta contado
\.


--
-- TOC entry 1990 (class 2606 OID 65809)
-- Name: abono_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bono
    ADD CONSTRAINT abono_pkey PRIMARY KEY (cod_abono);


--
-- TOC entry 1985 (class 2606 OID 65708)
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cedula_cliente);


--
-- TOC entry 1993 (class 2606 OID 65858)
-- Name: consecutivo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY consecutivo
    ADD CONSTRAINT consecutivo_pkey PRIMARY KEY (id_consecutivo);


--
-- TOC entry 1987 (class 2606 OID 65884)
-- Name: cuentas_cobrar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cuentas_cobrar
    ADD CONSTRAINT cuentas_cobrar_pkey PRIMARY KEY (numero_factura);


--
-- TOC entry 1983 (class 2606 OID 65682)
-- Name: empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (cedula_empleado);


--
-- TOC entry 2012 (class 2606 OID 74175)
-- Name: factura_devolucion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY factura_devolucion
    ADD CONSTRAINT factura_devolucion_pkey PRIMARY KEY (cod_devolucion);


--
-- TOC entry 1998 (class 2606 OID 65900)
-- Name: factura_venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY factura_venta
    ADD CONSTRAINT factura_venta_pkey PRIMARY KEY (numero_factura);


--
-- TOC entry 1972 (class 2606 OID 65634)
-- Name: inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (cod_producto);


--
-- TOC entry 2010 (class 2606 OID 74189)
-- Name: kardex_devolucion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY kardex_devolucion
    ADD CONSTRAINT kardex_devolucion_pkey PRIMARY KEY (cod_item_devolucion);


--
-- TOC entry 2006 (class 2606 OID 66030)
-- Name: kardex_entrada_historico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY kardex_entrada_historico
    ADD CONSTRAINT kardex_entrada_historico_pkey PRIMARY KEY (cod_entrada);


--
-- TOC entry 1981 (class 2606 OID 65665)
-- Name: kardex_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY kardex_entrada
    ADD CONSTRAINT kardex_pkey PRIMARY KEY (cod_entrada);


--
-- TOC entry 2004 (class 2606 OID 65947)
-- Name: kardex_salida_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY kardex_salida
    ADD CONSTRAINT kardex_salida_pkey PRIMARY KEY (cod_salida);


--
-- TOC entry 1996 (class 2606 OID 65867)
-- Name: kardex_venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY kardex_venta
    ADD CONSTRAINT kardex_venta_pkey PRIMARY KEY (cod_venta);


--
-- TOC entry 1970 (class 2606 OID 65620)
-- Name: laboratorio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY laboratorio
    ADD CONSTRAINT laboratorio_pkey PRIMARY KEY (cod_laboratorio);


--
-- TOC entry 1968 (class 2606 OID 65609)
-- Name: proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proveedor
    ADD CONSTRAINT proveedor_pkey PRIMARY KEY (nit_proveedor);


--
-- TOC entry 1974 (class 2606 OID 65657)
-- Name: transaccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_transaccion
    ADD CONSTRAINT transaccion_pkey PRIMARY KEY (cod_tipo_transaccion);


--
-- TOC entry 1991 (class 1259 OID 65824)
-- Name: fki_cedula_cliente_abono_fkey; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cedula_cliente_abono_fkey ON bono USING btree (cedula_cliente);


--
-- TOC entry 1988 (class 1259 OID 65798)
-- Name: fki_cedula_cliente_fkey; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cedula_cliente_fkey ON cuentas_cobrar USING btree (cedula_cliente);


--
-- TOC entry 2013 (class 1259 OID 74187)
-- Name: fki_cedula_empleado_devolucion; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cedula_empleado_devolucion ON factura_devolucion USING btree (cedula_empleado);


--
-- TOC entry 1999 (class 1259 OID 65906)
-- Name: fki_cedula_empleado_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cedula_empleado_fk ON factura_venta USING btree (cedula_empleado);


--
-- TOC entry 1975 (class 1259 OID 65688)
-- Name: fki_cedula_empleado_fkey; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cedula_empleado_fkey ON kardex_entrada USING btree (cedula_empleado);


--
-- TOC entry 2000 (class 1259 OID 65965)
-- Name: fki_cedula_empleado_kardex_salida_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cedula_empleado_kardex_salida_fk ON kardex_salida USING btree (cedula_empleado);


--
-- TOC entry 2007 (class 1259 OID 74195)
-- Name: fki_cod_devolucion_kardex_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cod_devolucion_kardex_fk ON kardex_devolucion USING btree (cod_devolucion);


--
-- TOC entry 1976 (class 1259 OID 65990)
-- Name: fki_cod_entrada_historico_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cod_entrada_historico_fk ON kardex_entrada USING btree (cedula_empleado);


--
-- TOC entry 1977 (class 1259 OID 65842)
-- Name: fki_cod_laboratorio_fkey; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cod_laboratorio_fkey ON kardex_entrada USING btree (cod_laboratorio);


--
-- TOC entry 2001 (class 1259 OID 65959)
-- Name: fki_cod_producto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cod_producto ON kardex_salida USING btree (cod_producto);


--
-- TOC entry 2008 (class 1259 OID 74201)
-- Name: fki_cod_producto_kardex_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cod_producto_kardex_fk ON kardex_devolucion USING btree (cod_producto);


--
-- TOC entry 1978 (class 1259 OID 65848)
-- Name: fki_cod_proveedor_entrada_fkey; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cod_proveedor_entrada_fkey ON kardex_entrada USING btree (nit_proveedor);


--
-- TOC entry 1979 (class 1259 OID 65677)
-- Name: fki_cod_tipo_transaccion; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cod_tipo_transaccion ON kardex_entrada USING btree (cod_tipo_transaccion);


--
-- TOC entry 2002 (class 1259 OID 65953)
-- Name: fki_cod_tipo_transaccion_kardex_salida_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_cod_tipo_transaccion_kardex_salida_fk ON kardex_salida USING btree (cod_tipo_transaccion);


--
-- TOC entry 2014 (class 1259 OID 74181)
-- Name: fki_numero_factura_devolucion_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_numero_factura_devolucion_fk ON factura_devolucion USING btree (numero_factura);


--
-- TOC entry 1994 (class 1259 OID 65912)
-- Name: fki_numero_factura_salida_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_numero_factura_salida_fk ON kardex_venta USING btree (numero_factura);


--
-- TOC entry 2023 (class 2606 OID 65819)
-- Name: cedula_cliente_abono_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bono
    ADD CONSTRAINT cedula_cliente_abono_fkey FOREIGN KEY (cedula_cliente) REFERENCES cliente(cedula_cliente);


--
-- TOC entry 2021 (class 2606 OID 65793)
-- Name: cedula_cliente_cuentas_cobrar_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cuentas_cobrar
    ADD CONSTRAINT cedula_cliente_cuentas_cobrar_fkey FOREIGN KEY (cedula_cliente) REFERENCES cliente(cedula_cliente);


--
-- TOC entry 2039 (class 2606 OID 74182)
-- Name: cedula_empleado_devolucion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura_devolucion
    ADD CONSTRAINT cedula_empleado_devolucion FOREIGN KEY (cedula_empleado) REFERENCES empleado(cedula_empleado);


--
-- TOC entry 2015 (class 2606 OID 65683)
-- Name: cedula_empleado_entrada_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_entrada
    ADD CONSTRAINT cedula_empleado_entrada_fkey FOREIGN KEY (cedula_empleado) REFERENCES empleado(cedula_empleado);


--
-- TOC entry 2027 (class 2606 OID 65901)
-- Name: cedula_empleado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura_venta
    ADD CONSTRAINT cedula_empleado_fk FOREIGN KEY (cedula_empleado) REFERENCES empleado(cedula_empleado);


--
-- TOC entry 2031 (class 2606 OID 66031)
-- Name: cedula_empleado_historico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_entrada_historico
    ADD CONSTRAINT cedula_empleado_historico_fk FOREIGN KEY (cedula_empleado) REFERENCES empleado(cedula_empleado);


--
-- TOC entry 2030 (class 2606 OID 65960)
-- Name: cedula_empleado_kardex_salida_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_salida
    ADD CONSTRAINT cedula_empleado_kardex_salida_fk FOREIGN KEY (cedula_empleado) REFERENCES empleado(cedula_empleado);


--
-- TOC entry 2036 (class 2606 OID 74190)
-- Name: cod_devolucion_kardex_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_devolucion
    ADD CONSTRAINT cod_devolucion_kardex_fk FOREIGN KEY (cod_devolucion) REFERENCES factura_devolucion(cod_devolucion);


--
-- TOC entry 2020 (class 2606 OID 65985)
-- Name: cod_entrada_historico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_entrada
    ADD CONSTRAINT cod_entrada_historico_fk FOREIGN KEY (cedula_empleado) REFERENCES empleado(cedula_empleado);


--
-- TOC entry 2018 (class 2606 OID 65837)
-- Name: cod_laboratorio_entrada_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_entrada
    ADD CONSTRAINT cod_laboratorio_entrada_fkey FOREIGN KEY (cod_laboratorio) REFERENCES laboratorio(cod_laboratorio);


--
-- TOC entry 2032 (class 2606 OID 66036)
-- Name: cod_laboratorio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_entrada_historico
    ADD CONSTRAINT cod_laboratorio_fk FOREIGN KEY (cod_laboratorio) REFERENCES laboratorio(cod_laboratorio);


--
-- TOC entry 2016 (class 2606 OID 65666)
-- Name: cod_producto_entrada_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_entrada
    ADD CONSTRAINT cod_producto_entrada_fkey FOREIGN KEY (cod_producto) REFERENCES inventario(cod_producto);


--
-- TOC entry 2033 (class 2606 OID 66041)
-- Name: cod_producto_hostorico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_entrada_historico
    ADD CONSTRAINT cod_producto_hostorico_fk FOREIGN KEY (cod_producto) REFERENCES inventario(cod_producto);


--
-- TOC entry 2037 (class 2606 OID 74196)
-- Name: cod_producto_kardex_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_devolucion
    ADD CONSTRAINT cod_producto_kardex_fk FOREIGN KEY (cod_producto) REFERENCES inventario(cod_producto);


--
-- TOC entry 2029 (class 2606 OID 65954)
-- Name: cod_producto_kardex_salida_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_salida
    ADD CONSTRAINT cod_producto_kardex_salida_fk FOREIGN KEY (cod_producto) REFERENCES inventario(cod_producto);


--
-- TOC entry 2024 (class 2606 OID 65873)
-- Name: cod_producto_kardex_venta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_venta
    ADD CONSTRAINT cod_producto_kardex_venta_fkey FOREIGN KEY (cod_producto) REFERENCES inventario(cod_producto);


--
-- TOC entry 2019 (class 2606 OID 65843)
-- Name: cod_proveedor_entrada_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_entrada
    ADD CONSTRAINT cod_proveedor_entrada_fkey FOREIGN KEY (nit_proveedor) REFERENCES proveedor(nit_proveedor);


--
-- TOC entry 2017 (class 2606 OID 65672)
-- Name: cod_tipo_transaccion_entrada_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_entrada
    ADD CONSTRAINT cod_tipo_transaccion_entrada_fkey FOREIGN KEY (cod_tipo_transaccion) REFERENCES tipo_transaccion(cod_tipo_transaccion);


--
-- TOC entry 2034 (class 2606 OID 66046)
-- Name: cod_tipo_transaccion_historico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_entrada_historico
    ADD CONSTRAINT cod_tipo_transaccion_historico_fk FOREIGN KEY (cod_tipo_transaccion) REFERENCES tipo_transaccion(cod_tipo_transaccion);


--
-- TOC entry 2028 (class 2606 OID 65948)
-- Name: cod_tipo_transaccion_kardex_salida_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_salida
    ADD CONSTRAINT cod_tipo_transaccion_kardex_salida_fk FOREIGN KEY (cod_tipo_transaccion) REFERENCES tipo_transaccion(cod_tipo_transaccion);


--
-- TOC entry 2026 (class 2606 OID 65878)
-- Name: cod_tipo_transaccion_kardex_venta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_venta
    ADD CONSTRAINT cod_tipo_transaccion_kardex_venta_fkey FOREIGN KEY (cod_tipo_transaccion) REFERENCES tipo_transaccion(cod_tipo_transaccion);


--
-- TOC entry 2022 (class 2606 OID 65913)
-- Name: cuentas_cobrar_numero_factura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cuentas_cobrar
    ADD CONSTRAINT cuentas_cobrar_numero_factura_fkey FOREIGN KEY (numero_factura) REFERENCES factura_venta(numero_factura);


--
-- TOC entry 2035 (class 2606 OID 66051)
-- Name: nit_proveedor_historico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_entrada_historico
    ADD CONSTRAINT nit_proveedor_historico_fk FOREIGN KEY (nit_proveedor) REFERENCES proveedor(nit_proveedor);


--
-- TOC entry 2038 (class 2606 OID 74176)
-- Name: numero_factura_devolucion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura_devolucion
    ADD CONSTRAINT numero_factura_devolucion_fk FOREIGN KEY (numero_factura) REFERENCES factura_venta(numero_factura);


--
-- TOC entry 2025 (class 2606 OID 65907)
-- Name: numero_factura_kardex_venta_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kardex_venta
    ADD CONSTRAINT numero_factura_kardex_venta_fk FOREIGN KEY (numero_factura) REFERENCES factura_venta(numero_factura);


--
-- TOC entry 2178 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-04-23 01:23:06

--
-- PostgreSQL database dump complete
--

