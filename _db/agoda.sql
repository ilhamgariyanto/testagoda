PGDMP  7    2                |            agoda    16.3    16.3 u    Y           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            Z           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            [           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            \           1262    34064    agoda    DATABASE     �   CREATE DATABASE agoda WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE agoda;
                postgres    false            �            1259    34629    cache    TABLE     �   CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);
    DROP TABLE public.cache;
       public         heap    postgres    false            �            1259    34636    cache_locks    TABLE     �   CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);
    DROP TABLE public.cache_locks;
       public         heap    postgres    false            �            1259    34682    cities    TABLE     R  CREATE TABLE public.cities (
    id bigint NOT NULL,
    category_id bigint,
    name character varying(100) NOT NULL,
    state character varying(50),
    country character varying(50),
    latitude numeric(9,6),
    longitude numeric(9,6),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.cities;
       public         heap    postgres    false            �            1259    34681    cities_id_seq    SEQUENCE     v   CREATE SEQUENCE public.cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.cities_id_seq;
       public          postgres    false    231            ]           0    0    cities_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;
          public          postgres    false    230            �            1259    34673    city_categories    TABLE     �   CREATE TABLE public.city_categories (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 #   DROP TABLE public.city_categories;
       public         heap    postgres    false            �            1259    34672    city_categories_id_seq    SEQUENCE        CREATE SEQUENCE public.city_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.city_categories_id_seq;
       public          postgres    false    229            ^           0    0    city_categories_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.city_categories_id_seq OWNED BY public.city_categories.id;
          public          postgres    false    228            �            1259    34661    failed_jobs    TABLE     &  CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.failed_jobs;
       public         heap    postgres    false            �            1259    34660    failed_jobs_id_seq    SEQUENCE     {   CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.failed_jobs_id_seq;
       public          postgres    false    227            _           0    0    failed_jobs_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;
          public          postgres    false    226            �            1259    34737    hotel_bookings    TABLE     �  CREATE TABLE public.hotel_bookings (
    id bigint NOT NULL,
    hotel_id bigint NOT NULL,
    user_id bigint NOT NULL,
    price_id bigint NOT NULL,
    room_count integer NOT NULL,
    check_in_date date NOT NULL,
    check_out_date date NOT NULL,
    total_price numeric(10,2) NOT NULL,
    booking_status character varying(255) DEFAULT 'Confirmed'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT hotel_bookings_booking_status_check CHECK (((booking_status)::text = ANY ((ARRAY['Confirmed'::character varying, 'Cancelled'::character varying])::text[])))
);
 "   DROP TABLE public.hotel_bookings;
       public         heap    postgres    false            �            1259    34736    hotel_bookings_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.hotel_bookings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.hotel_bookings_id_seq;
       public          postgres    false    239            `           0    0    hotel_bookings_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.hotel_bookings_id_seq OWNED BY public.hotel_bookings.id;
          public          postgres    false    238            �            1259    34709    hotel_details    TABLE     �   CREATE TABLE public.hotel_details (
    id bigint NOT NULL,
    hotel_id bigint NOT NULL,
    description text,
    facilitases text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 !   DROP TABLE public.hotel_details;
       public         heap    postgres    false            �            1259    34708    hotel_details_id_seq    SEQUENCE     }   CREATE SEQUENCE public.hotel_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.hotel_details_id_seq;
       public          postgres    false    235            a           0    0    hotel_details_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.hotel_details_id_seq OWNED BY public.hotel_details.id;
          public          postgres    false    234            �            1259    34723    hotel_prices    TABLE     c  CREATE TABLE public.hotel_prices (
    id bigint NOT NULL,
    hotel_id bigint NOT NULL,
    room_type character varying(50) NOT NULL,
    price_per_night numeric(10,2) NOT NULL,
    description text,
    start_date date NOT NULL,
    end_date date NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
     DROP TABLE public.hotel_prices;
       public         heap    postgres    false            �            1259    34722    hotel_prices_id_seq    SEQUENCE     |   CREATE SEQUENCE public.hotel_prices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.hotel_prices_id_seq;
       public          postgres    false    237            b           0    0    hotel_prices_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.hotel_prices_id_seq OWNED BY public.hotel_prices.id;
          public          postgres    false    236            �            1259    34694    hotels    TABLE     �  CREATE TABLE public.hotels (
    id bigint NOT NULL,
    city_id bigint,
    name character varying(100) NOT NULL,
    address text NOT NULL,
    latitude numeric(9,6),
    longitude numeric(9,6),
    price numeric(10,2) NOT NULL,
    description text,
    rating integer DEFAULT 0 NOT NULL,
    phone character varying(20),
    email character varying(100),
    website character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.hotels;
       public         heap    postgres    false            �            1259    34693    hotels_id_seq    SEQUENCE     v   CREATE SEQUENCE public.hotels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.hotels_id_seq;
       public          postgres    false    233            c           0    0    hotels_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.hotels_id_seq OWNED BY public.hotels.id;
          public          postgres    false    232            �            1259    34653    job_batches    TABLE     d  CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);
    DROP TABLE public.job_batches;
       public         heap    postgres    false            �            1259    34644    jobs    TABLE     �   CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);
    DROP TABLE public.jobs;
       public         heap    postgres    false            �            1259    34643    jobs_id_seq    SEQUENCE     t   CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.jobs_id_seq;
       public          postgres    false    224            d           0    0    jobs_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;
          public          postgres    false    223            �            1259    34066 
   migrations    TABLE     �   CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);
    DROP TABLE public.migrations;
       public         heap    postgres    false            �            1259    34065    migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.migrations_id_seq;
       public          postgres    false    216            e           0    0    migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;
          public          postgres    false    215            �            1259    34613    password_reset_tokens    TABLE     �   CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);
 )   DROP TABLE public.password_reset_tokens;
       public         heap    postgres    false            �            1259    34761    payments    TABLE     -  CREATE TABLE public.payments (
    id bigint NOT NULL,
    booking_id bigint NOT NULL,
    payment_date timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_method character varying(255) NOT NULL,
    payment_status character varying(255) DEFAULT 'Successful'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT payments_payment_method_check CHECK (((payment_method)::text = ANY ((ARRAY['Credit Card'::character varying, 'PayPal'::character varying, 'Bank Transfer'::character varying])::text[]))),
    CONSTRAINT payments_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['Successful'::character varying, 'Failed'::character varying])::text[])))
);
    DROP TABLE public.payments;
       public         heap    postgres    false            �            1259    34760    payments_id_seq    SEQUENCE     x   CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.payments_id_seq;
       public          postgres    false    241            f           0    0    payments_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;
          public          postgres    false    240            �            1259    34620    sessions    TABLE     �   CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);
    DROP TABLE public.sessions;
       public         heap    postgres    false            �            1259    34780    tourist_spots    TABLE     ;  CREATE TABLE public.tourist_spots (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    latitude numeric(10,7) NOT NULL,
    longitude numeric(10,7) NOT NULL,
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    city_id bigint
);
 !   DROP TABLE public.tourist_spots;
       public         heap    postgres    false            �            1259    34779    tourist_spots_id_seq    SEQUENCE     }   CREATE SEQUENCE public.tourist_spots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.tourist_spots_id_seq;
       public          postgres    false    243            g           0    0    tourist_spots_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.tourist_spots_id_seq OWNED BY public.tourist_spots.id;
          public          postgres    false    242            �            1259    34603    users    TABLE     x  CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    34602    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    218            h           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    217            k           2604    34685 	   cities id    DEFAULT     f   ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);
 8   ALTER TABLE public.cities ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    230    231            j           2604    34676    city_categories id    DEFAULT     x   ALTER TABLE ONLY public.city_categories ALTER COLUMN id SET DEFAULT nextval('public.city_categories_id_seq'::regclass);
 A   ALTER TABLE public.city_categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    229    229            h           2604    34664    failed_jobs id    DEFAULT     p   ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);
 =   ALTER TABLE public.failed_jobs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    227    227            p           2604    34740    hotel_bookings id    DEFAULT     v   ALTER TABLE ONLY public.hotel_bookings ALTER COLUMN id SET DEFAULT nextval('public.hotel_bookings_id_seq'::regclass);
 @   ALTER TABLE public.hotel_bookings ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    239    239            n           2604    34712    hotel_details id    DEFAULT     t   ALTER TABLE ONLY public.hotel_details ALTER COLUMN id SET DEFAULT nextval('public.hotel_details_id_seq'::regclass);
 ?   ALTER TABLE public.hotel_details ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    235    235            o           2604    34726    hotel_prices id    DEFAULT     r   ALTER TABLE ONLY public.hotel_prices ALTER COLUMN id SET DEFAULT nextval('public.hotel_prices_id_seq'::regclass);
 >   ALTER TABLE public.hotel_prices ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    237    236    237            l           2604    34697 	   hotels id    DEFAULT     f   ALTER TABLE ONLY public.hotels ALTER COLUMN id SET DEFAULT nextval('public.hotels_id_seq'::regclass);
 8   ALTER TABLE public.hotels ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    233    233            g           2604    34647    jobs id    DEFAULT     b   ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);
 6   ALTER TABLE public.jobs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224            e           2604    34069    migrations id    DEFAULT     n   ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);
 <   ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            r           2604    34764    payments id    DEFAULT     j   ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);
 :   ALTER TABLE public.payments ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    241    240    241            u           2604    34783    tourist_spots id    DEFAULT     t   ALTER TABLE ONLY public.tourist_spots ALTER COLUMN id SET DEFAULT nextval('public.tourist_spots_id_seq'::regclass);
 ?   ALTER TABLE public.tourist_spots ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    243    242    243            f           2604    34606    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            @          0    34629    cache 
   TABLE DATA           7   COPY public.cache (key, value, expiration) FROM stdin;
    public          postgres    false    221   �       A          0    34636    cache_locks 
   TABLE DATA           =   COPY public.cache_locks (key, owner, expiration) FROM stdin;
    public          postgres    false    222   �       J          0    34682    cities 
   TABLE DATA           t   COPY public.cities (id, category_id, name, state, country, latitude, longitude, created_at, updated_at) FROM stdin;
    public          postgres    false    231   !�       H          0    34673    city_categories 
   TABLE DATA           X   COPY public.city_categories (id, name, description, created_at, updated_at) FROM stdin;
    public          postgres    false    229   ��       F          0    34661    failed_jobs 
   TABLE DATA           a   COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
    public          postgres    false    227   ��       R          0    34737    hotel_bookings 
   TABLE DATA           �   COPY public.hotel_bookings (id, hotel_id, user_id, price_id, room_count, check_in_date, check_out_date, total_price, booking_status, created_at, updated_at) FROM stdin;
    public          postgres    false    239   Ж       N          0    34709    hotel_details 
   TABLE DATA           g   COPY public.hotel_details (id, hotel_id, description, facilitases, created_at, updated_at) FROM stdin;
    public          postgres    false    235   �       P          0    34723    hotel_prices 
   TABLE DATA           �   COPY public.hotel_prices (id, hotel_id, room_type, price_per_night, description, start_date, end_date, created_at, updated_at) FROM stdin;
    public          postgres    false    237   ��       L          0    34694    hotels 
   TABLE DATA           �   COPY public.hotels (id, city_id, name, address, latitude, longitude, price, description, rating, phone, email, website, created_at, updated_at) FROM stdin;
    public          postgres    false    233   ֙       D          0    34653    job_batches 
   TABLE DATA           �   COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
    public          postgres    false    225   0�       C          0    34644    jobs 
   TABLE DATA           c   COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
    public          postgres    false    224   M�       ;          0    34066 
   migrations 
   TABLE DATA           :   COPY public.migrations (id, migration, batch) FROM stdin;
    public          postgres    false    216   j�       >          0    34613    password_reset_tokens 
   TABLE DATA           I   COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
    public          postgres    false    219   5�       T          0    34761    payments 
   TABLE DATA           �   COPY public.payments (id, booking_id, payment_date, amount, payment_method, payment_status, created_at, updated_at) FROM stdin;
    public          postgres    false    241   R�       ?          0    34620    sessions 
   TABLE DATA           _   COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
    public          postgres    false    220   o�       V          0    34780    tourist_spots 
   TABLE DATA           t   COPY public.tourist_spots (id, name, latitude, longitude, description, created_at, updated_at, city_id) FROM stdin;
    public          postgres    false    243   ��       =          0    34603    users 
   TABLE DATA           u   COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
    public          postgres    false    218   M�       i           0    0    cities_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.cities_id_seq', 20, true);
          public          postgres    false    230            j           0    0    city_categories_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.city_categories_id_seq', 20, true);
          public          postgres    false    228            k           0    0    failed_jobs_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);
          public          postgres    false    226            l           0    0    hotel_bookings_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.hotel_bookings_id_seq', 1, false);
          public          postgres    false    238            m           0    0    hotel_details_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.hotel_details_id_seq', 10, true);
          public          postgres    false    234            n           0    0    hotel_prices_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.hotel_prices_id_seq', 1, false);
          public          postgres    false    236            o           0    0    hotels_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.hotels_id_seq', 40, true);
          public          postgres    false    232            p           0    0    jobs_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);
          public          postgres    false    223            q           0    0    migrations_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.migrations_id_seq', 41, true);
          public          postgres    false    215            r           0    0    payments_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.payments_id_seq', 1, false);
          public          postgres    false    240            s           0    0    tourist_spots_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.tourist_spots_id_seq', 50, true);
          public          postgres    false    242            t           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 1, false);
          public          postgres    false    217            �           2606    34642    cache_locks cache_locks_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);
 F   ALTER TABLE ONLY public.cache_locks DROP CONSTRAINT cache_locks_pkey;
       public            postgres    false    222            �           2606    34635    cache cache_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);
 :   ALTER TABLE ONLY public.cache DROP CONSTRAINT cache_pkey;
       public            postgres    false    221            �           2606    34687    cities cities_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_pkey;
       public            postgres    false    231            �           2606    34680 $   city_categories city_categories_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.city_categories
    ADD CONSTRAINT city_categories_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.city_categories DROP CONSTRAINT city_categories_pkey;
       public            postgres    false    229            �           2606    34669    failed_jobs failed_jobs_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.failed_jobs DROP CONSTRAINT failed_jobs_pkey;
       public            postgres    false    227            �           2606    34671 #   failed_jobs failed_jobs_uuid_unique 
   CONSTRAINT     ^   ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);
 M   ALTER TABLE ONLY public.failed_jobs DROP CONSTRAINT failed_jobs_uuid_unique;
       public            postgres    false    227            �           2606    34744 "   hotel_bookings hotel_bookings_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.hotel_bookings
    ADD CONSTRAINT hotel_bookings_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.hotel_bookings DROP CONSTRAINT hotel_bookings_pkey;
       public            postgres    false    239            �           2606    34716     hotel_details hotel_details_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.hotel_details
    ADD CONSTRAINT hotel_details_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.hotel_details DROP CONSTRAINT hotel_details_pkey;
       public            postgres    false    235            �           2606    34730    hotel_prices hotel_prices_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.hotel_prices
    ADD CONSTRAINT hotel_prices_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.hotel_prices DROP CONSTRAINT hotel_prices_pkey;
       public            postgres    false    237            �           2606    34702    hotels hotels_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT hotels_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.hotels DROP CONSTRAINT hotels_pkey;
       public            postgres    false    233            �           2606    34659    job_batches job_batches_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.job_batches DROP CONSTRAINT job_batches_pkey;
       public            postgres    false    225            �           2606    34651    jobs jobs_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.jobs DROP CONSTRAINT jobs_pkey;
       public            postgres    false    224            z           2606    34071    migrations migrations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.migrations DROP CONSTRAINT migrations_pkey;
       public            postgres    false    216            �           2606    34619 0   password_reset_tokens password_reset_tokens_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);
 Z   ALTER TABLE ONLY public.password_reset_tokens DROP CONSTRAINT password_reset_tokens_pkey;
       public            postgres    false    219            �           2606    34772    payments payments_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_pkey;
       public            postgres    false    241            �           2606    34626    sessions sessions_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey;
       public            postgres    false    220            �           2606    34787     tourist_spots tourist_spots_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.tourist_spots
    ADD CONSTRAINT tourist_spots_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.tourist_spots DROP CONSTRAINT tourist_spots_pkey;
       public            postgres    false    243            |           2606    34612    users users_email_unique 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_unique;
       public            postgres    false    218            ~           2606    34610    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    218            �           1259    34652    jobs_queue_index    INDEX     B   CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);
 $   DROP INDEX public.jobs_queue_index;
       public            postgres    false    224            �           1259    34628    sessions_last_activity_index    INDEX     Z   CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);
 0   DROP INDEX public.sessions_last_activity_index;
       public            postgres    false    220            �           1259    34627    sessions_user_id_index    INDEX     N   CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);
 *   DROP INDEX public.sessions_user_id_index;
       public            postgres    false    220            �           2606    34688 !   cities cities_category_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_category_id_foreign FOREIGN KEY (category_id) REFERENCES public.city_categories(id) ON DELETE SET NULL;
 K   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_category_id_foreign;
       public          postgres    false    231    229    4755            �           2606    34745 .   hotel_bookings hotel_bookings_hotel_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.hotel_bookings
    ADD CONSTRAINT hotel_bookings_hotel_id_foreign FOREIGN KEY (hotel_id) REFERENCES public.hotels(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.hotel_bookings DROP CONSTRAINT hotel_bookings_hotel_id_foreign;
       public          postgres    false    239    233    4759            �           2606    34755 .   hotel_bookings hotel_bookings_price_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.hotel_bookings
    ADD CONSTRAINT hotel_bookings_price_id_foreign FOREIGN KEY (price_id) REFERENCES public.hotel_prices(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.hotel_bookings DROP CONSTRAINT hotel_bookings_price_id_foreign;
       public          postgres    false    237    4763    239            �           2606    34750 -   hotel_bookings hotel_bookings_user_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.hotel_bookings
    ADD CONSTRAINT hotel_bookings_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.hotel_bookings DROP CONSTRAINT hotel_bookings_user_id_foreign;
       public          postgres    false    239    4734    218            �           2606    34717 ,   hotel_details hotel_details_hotel_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.hotel_details
    ADD CONSTRAINT hotel_details_hotel_id_foreign FOREIGN KEY (hotel_id) REFERENCES public.hotels(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.hotel_details DROP CONSTRAINT hotel_details_hotel_id_foreign;
       public          postgres    false    4759    235    233            �           2606    34731 *   hotel_prices hotel_prices_hotel_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.hotel_prices
    ADD CONSTRAINT hotel_prices_hotel_id_foreign FOREIGN KEY (hotel_id) REFERENCES public.hotels(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.hotel_prices DROP CONSTRAINT hotel_prices_hotel_id_foreign;
       public          postgres    false    237    233    4759            �           2606    34703    hotels hotels_city_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT hotels_city_id_foreign FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE SET NULL;
 G   ALTER TABLE ONLY public.hotels DROP CONSTRAINT hotels_city_id_foreign;
       public          postgres    false    231    233    4757            �           2606    34773 $   payments payments_booking_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_booking_id_foreign FOREIGN KEY (booking_id) REFERENCES public.hotel_bookings(id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_booking_id_foreign;
       public          postgres    false    4765    239    241            �           2606    34788 +   tourist_spots tourist_spots_city_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.tourist_spots
    ADD CONSTRAINT tourist_spots_city_id_foreign FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE SET NULL;
 U   ALTER TABLE ONLY public.tourist_spots DROP CONSTRAINT tourist_spots_city_id_foreign;
       public          postgres    false    243    231    4757            @      x������ � �      A      x������ � �      J   R  x��U�n�@<7_�`4�G�l.l	�����������؊���6a1!�˒��7}��w|�l�-v���&�anYN[�;fER��RϹ�K�	����_���_�VbW�7��rV�#��A�dp
��z��)����(�[���5hB�a�!<>-�����ލ�Ĥ�	!ހ��oq��x�����v
�4N;	BH�q��Ƃ�_�����2�|]p�`������A��	9p�5�$�k���y,]n��b|M���᱈{<`K��)�g�p��0yp� /4�� ���f�v�$�	��5D�V�)�LBV����d��C0��Ѵ&��`D��'�����E�mng����G{҈�IG'�IRu��ڞ������J)N��̨q�`�=c����y!��!�a����H砍�!o��93gs��<$�VM�J���'�g��t-g\Z5v�ҒDI�@���a\c�Ï�	6g�;n���9w�Ը����l:��JmA�7�S5�̤�]V��<�)�9��s�~��0%�i�J~O+t�Xa�q����,�p�iZ�֘�X�a;w��B�����B��^�o6���!h�J      H      x��VMo�0<�_��V@K�n����J��*��E���ĉ���~�6IE+r@
��yof�83�$�{]�U�g��/�_�!�w��RBS�s���z���[���qG�Rja�ڒ�b����rz9_����z�8�=uo2g?%9a�	C[ވ�k!P��g;�E4�B�W$oP��;:����*l�Vh��VZ��S2��;<�g^�҉md��X�9���B��#��y��Za�g��ZXI��,t,�Ԏ���2i�A��m���v��FOIo%r�1S�4ɩ��/Yys>�-���ݾ��.P���B����g��z� R�Bh�
-�G�c��Q{6S�q��dd�+'�RD1U]�ZB�(����$���}I�w	A.�Ȕ�-5�Ǎw� p��R��Sܢ�cK���趐�h�7(���|��\�O��2��W*{ғ �����?��7���WaƉ�v���8K0GxX�G�d��-�޷~"Gx旿w�օDkx�s�^R���a����I�c�j�uLo��JU���gT�(i�=Q	�E���)�(x�n��:n�ss�������WD���1l/غ�W���W��*̚���E�{�ڒ��@|Ke�U�C����-[4���_��.��!�1�u]�Az��zǞ�n(Lz�6�_�m8�Jy��)<D^r��{���;3�}�����Vx��j��<�ߍqP�b����.`�O�v�c��3�W2M]�����׃���#�+�b�G�[x�����5&R�\M&��O۴      F      x������ � �      R      x������ � �      N   �  x��UMo�0=�_1? ����۲R�*= Zm/{�4n�&q"����ر)�ª�H�̳y���0񣱲���EU�r��3h�l,�U�q=��@oh�"�*.�؂��Fӕ����F��i1���eSa��7�b�<9��7W�����k�dX�.I��x:;_�M/`2��Mnϧ�j#����:rme�������(���-�u�s/��E��p�L^�JR2����U���DD�_�q.΃c�Y�az%O"����_��t:�5?c-�V��`:��RV�bJ>�a:�w�y(��jQX�������,l&fA؁�Ԭe����26C[ǈ����p�n��e��+j䫴��oP�q�M����nw`�9�E�_,�ei�b(�eFF�	rQ�RKt����}��g��W�m4�C����gl�3������Smx).c���.*˥A�/�|�h���'C�')��u�S����g���El�J�J\�j���_��˿�}w,3�8�1�g�`i���R�0K��L��ѵ�>��S~��U�g�h�=���yD��c	��y�=7��o�̃?3L<�����E�F��)�͠�xN����ٻ툧b��HN�%�b�R��U��S��	�C�TOMƂ?� &U���YZW^VnQv�e�%��A��A��4��� c�zO�w��_�h4����V      P      x������ � �      L   J	  x���I��6���_��Ċ�K>���c��nONs�$X��큤ۚ_?�� �E��/-	Y_�Ur��VO퀫�#�":��7E��c���\PMI�ٮ�x��t��M�N6��*��m\��e�?Z�Kq�iԜ�<:��{4D��0=鄛3j���'PU��u�U��G�DI�I��E�"����o�{G!���֫�0t�۟~}}];��M���l�$9��6ݾ��=$J(jN����e<Z#��$7��UJ��L%��]&�ÍN���U���Kb�][P�q����h�u
�*����%�V7��D'�xi K��xNݞ0�w�	��������b��7����NX|d����P���������Mۡ�pz^sy�2v���~���}�n���SDd���(�K"~�����i(u���p��"��@C;��ZN�]R�3�P�.wB[�}Z����*��w,,}���H>c��Cɋ�u K�p���9A�X�yj$��r��m��Wx6W�W�� �1��YN("Q.pbzua���T����.!>�Aox�f��3�r�� w�㊅)WąFHY��T8A�$�Q[���[���|�/�:ڣ9�'���=�]޲<5\�9_��Q\���"_�g��xϧ��j�)5<�7#>cz�W�����i%�^Ɵ@I?��8��4|A��S&���:e�7
z�ԏ�{ra���MV�����TS@����]����Z
[f@��
��ҧ�q�&�U,�}�m���͙��=Eg���O'�����r]lJ��l==^f�x�&wz<��d��!&�A|��-�$q}� �5^4x<,�O3�~3��"��uw�^*�'QY�Y������}E0x������~��+���[���b��ńΛ�Ua���d��*�o�t�\޽�������jn��;&��>t���"�s��+:�rk@g���.��9��5p^%@N�A�(��/��Om�d����:���`�\��V�fT��=�Hv����ӄ�t:���r�c&���:�-�g^t���@�:;ߩ��be��Ұ�4����9u����t҃>Z��ĥ"~l�s�~o��H`b���U3�O�	���#{sC5R���PVqX��H�ZVѼ���m�q0�Vq�1�����L�(�Ұj��5k��ZͲ�5=W��t�h����"�u�X�0��:/��S��������(S�;m5#8ؓ��I�@�b��՗r�^�(>f�y(q��s���wb"�:�G�0pl��$�y��ҝ��z�3sI��� *t�FT�f!�71�����*QC8�O=㾥�phhB�����x˨�<�s���M����q��bݏ���:h��5̢);r)(�c27�%��[����H�'Z�ȸ^��ٴ��Ց���ޙI��Z���𙻛��q��ݕ���
H�^0��Ԛ�����N�U����GԃU!7L�'w�:o��ǃ�8���?A�^7����w��{��6J���͇1s Y�"* �Y.�b���]�l�Z&�G�Y0~����榻��9
��Q��(��E�X���
վ��E��a�O�iE��A��>�6|?6Gt]d�xi����;����y̆��k�ƞ|Ռm��j)K�=x.	VF���b�@U����`Rj1�M������_�υ|���H��o�vfB}�2y�"����ж#G�?> ��E��	�F�>��Yd����?�B7���f���D�O}K�A�v�Y*p���3t�?� =����Dn K#���^�(ۿI n~�ٺ�)���;7%����BqӍ��:9��?��s�w����7*�&���$��.��}��λdk�4�Kn���1x��YX,B:��m��>}����2��6~{VN����?�v�z�ƭOk�1-�p}��&J	��R�r*������6R1�g������s�����sC��0�EQ�!`5��wvS	k)�:VB���傣'r�@Grr9�R���9���:��.�������Nv�Y0wfE�ѫ�=��" 
���pǋ����^���̀���R�xh���^���
\�g<� �l�zh*oꝱ��d�E!w���ؿ:�S��"�Q!�'���������n���~a\��p���:."]����Ylq2sQ5��"�ź�8��T��c?����;�r��=����&/v�#�{H*r�ܢ���˜E�'��c�O�ѷ
}�d����Vxo�Zc�����fy���Rk)��u���R���uz����n�^j��3��6�wߞ�Ta���އk��f�*�6z�۳���&5k�6�/��'����l�����8�4���뇇���fJ      D      x������ � �      C      x������ � �      ;   �   x�e���0��k�0�;qx�f`�Std��^�c,����Ӳ  ���>�"9&�F�#�k{*��� �";��h�� �"�MV�B�25*����r]�y��e���)il��*iv�̩^�vL}B���=���iQ煵�b��K�i����m��n��<�fI7?��	��j�,����8a-�8��o�Қ�      >      x������ � �      T      x������ � �      ?     x���K��@���+Xv'�
H����V!� �7�l�V��O�#��Ugrw�䜓{�Z�����N�V6����bR_�G ���B�g�6�����G�-ع����rlHU��"@/X���+c�PCLACS�hY�Dd2���W��_7� ���Z�y�rO6nV�49�7d�M�8),]Y�?��G�]f�4��5� �����:�IY�OF�>t����#8��7Tf4V�yiA��hlt�hr���0��em�u���u�l�	>���m������O�5��_;��vQ�HZ�2��rY2v��sOҀ
���2��zl�g"���\V�c���t?״��X��ψu��d�D�!"ǜ�g���'�/��$ܠ�(��Q��H3Tem C�afh�K��P�";�Ga�?1L�g�(��]r"ߖ	Gw�/
��"��"�Ew���6�q�JH���L��z�[��� '�A��K��܏�㒑؞�f_N��
�����B<[������-���m�oR���J�u����k�G      V   �  x��X�r�F<�_�G;Bf �gIіײ��^El�Rc��� � Z������_��=CR��
�itVUVeU1�n�����]ɑ�RO{-in���,�q���e.��H��9ifG�"�ţy��t��n�->��=oU���e��{���Gȯ��:����f�VY�\T�E.�X�op�(u�|X�:z���g���������t'�i��٨��7m�o^�*����܌s�8�=�0YTM#���� f�k5�-��JV�4IK�b�iG�زS��Zv0�vj���Ж�a���m�8&�<�'��>ȉfbW���A���*���h_09Ow�W#ke'�)g��rG* ."��d�X�Ҋ{��H+7�4�6n�I:�_�x��F�� ��n`��7�W���4�Mt�)U)�)��A���a]�K��rD�] UE��Gb���d��ST��'\\�����=
b��G{�C:��^�̖���}SGG�Q�'����Z��P5���	�"�>�<`���wq}@��r6��v��Y��ת�3 {8wZA��ͪ"���p�ͤ~|;ˉ�~Vte�3�H����+�{�]_�����"�S�v�0(VQh�����g��8�u4�'��`��<z���+N�%���ǁq�|56�5jjv����7�j��C/���AM�:	l�����%�G_}3I�O�jH.�$w��T��?�����ާ�7*Pͨ�hϦE���w��Yt��<���8 �j�e\�N�%O�<���r��5��f���lj�����:�S_�h������SH���D�uѽ�;'}L��*��2R���V��h�G�!b��٦�;z6<��p�9_򇗱�����k ݤ�^c�lL�����{4D��J�"�*]���ld�Eo���m�h<X�4��Uэz��/n�7���$�t<�<�<
]&6u�h���Z$�\"]ti��a�I�'�I��!��E͔�M��"���"j
7ZS�����qt��6o�ۛ��P�E*X�s70^��H�o���h=Ñw���-�Do�\q�f��+/y\����`@��b�E��Ә�#�G7����?��?��{�%����*��2!��y��4n}��裑r���3��9�!x}C���'м����8�9�C�Q��t��8-�y
i�Ǔ�ų���x����뇍�1NL�������,u�df�iL�H�O[XҪ����k�S��,^�K�=]9mj�$���J��z�dbT6�*���W��|�4=Y�8�K���d~1ğ��HdL'��G� `�A�����i�X�8Z��_����T�~j���nt��V�'4DL�F������Ĵ ��:q�)�䇣Բ��־nLv!w���NT��Z�%������Š�iZz�"-�N�-���<6���'W��EB�BSP���U-�ev�.���E�T�T�7?d��,X��l?Os,:-������w���*|Q�Y�l|G��YB b�p���)A�'��<tCR �I��j��s${?F{����l�t�I��t\�����zg��1�/�p����w�	#��_A�+��!�������*8.#��X�6 ����	��*��� �ɸ�b'Qb���gG$eVd�:�cL,�5�aZc�M���뺝\;zht2�~����qtK:[�iT�W7�u�;�i��W�I��U�e!ь�ˏ:��Bj��������C����z����E˪bo�.�u���K���%6w�B��T�o0�x�UfV�տ��`o���M)^
�3�:�{��W��'��'��_O֫^�?x��������������Wy��a�������� �m:�zyi���ڲ�T&�_�l7ɺ�r��ߺ�$n��}�P<����ߦ�M���v��p��3,���*MWmRؓc�/�@�m���a���ˋ��_E�y�      =      x������ � �     