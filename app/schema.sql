DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS article;
DROP TABLE IF EXISTS human_verification_query;
DROP TABLE IF EXISTS human_verification_query_answer;
DROP TABLE IF EXISTS article_comment;
DROP TABLE IF EXISTS article_like;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS sub_category;
DROP TABLE IF EXISTS article_category;
DROP TABLE IF EXISTS user_interest;


CREATE TABLE
    IF NOT EXISTS user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullname VARCHAR(50) NOT NULL,
        email VARCHAR(100) NOT NULL,
        phone_number VARCHAR(200) NOT NULL UNIQUE,
        phone_number_last_digits INTEGER (3) NOT NULL,
        dob DATE NOT NULL,
        gender VARCHAR(5) NOT NULL,
        username VARCHAR(20) NOT NULL,
        password VARCHAR(200) NOT NULL,
        profile_picture_uri VARCHAR(50) NULL
    );

CREATE TABLE
    IF NOT EXISTS human_verification_query (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        body VARCHAR(50) NOT NULL
    );

 CREATE TABLE
    IF NOT EXISTS human_verification_query_answer (
        id INTEGER NOT NULL,
        anwser VARCHAR(10) NOT NULL,
        PRIMARY KEY (id, anwser),
        FOREIGN KEY (id) REFERENCES human_verification_query (id) ON DELETE RESTRICT ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS article (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        author_id INTEGER (10) NOT NULL,
        title VARCHAR(50) NOT NULL,
        body TEXT NOT NULL,
        description VARCHAR(100) NOT NULL,
        created DATETIME NOT NULL,
        FOREIGN KEY (author_id) REFERENCES user (id) ON DELETE RESTRICT ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS article_comment (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        body TEXT NOT NULL,
        article_id INTEGER (10) NOT NULL,
        created DATETIME NOT NULL,
        edited DATETIME NULL,
        user_id INTEGER (10) NOT NULL,
        FOREIGN KEY (article_id) REFERENCES article (id) ON DELETE RESTRICT ON UPDATE CASCADE,
        FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE RESTRICT ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS article_like (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        article_id INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        FOREIGN KEY (article_id) REFERENCES article (id) ON DELETE RESTRICT ON UPDATE CASCADE,
        FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE RESTRICT ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS category (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        label CHAR(20) NOT NULL UNIQUE
    );

CREATE TABLE
    IF NOT EXISTS sub_category (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        label CHAR(20) NOT NULL UNIQUE,
        category_id CHAR(20) NOT NULL,
        FOREIGN KEY (category_id) REFERENCES category (id) ON UPDATE CASCADE ON DELETE RESTRICT
    );

CREATE TABLE
    IF NOT EXISTS article_category (
        article_id INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        PRIMARY KEY (article_id, category_id),
        FOREIGN KEY (category_id) REFERENCES category (id) ON UPDATE CASCADE ON DELETE RESTRICT,
        FOREIGN KEY (article_id) REFERENCES article (id) ON UPDATE CASCADE ON DELETE RESTRICT
    );

CREATE TABLE
    IF NOT EXISTS user_interest (
        user_id INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        PRIMARY KEY (user_id, category_id),
        FOREIGN KEY (user_id) REFERENCES user (id) ON UPDATE CASCADE ON DELETE RESTRICT,
        FOREIGN KEY (category_id) REFERENCES category (id) ON UPDATE CASCADE ON DELETE RESTRICT
    );

-- Dummy Data
insert into
    category (label)
values
    ("Entertainmet");

insert into
    category (label)
values
    ("Technology");

insert into
    category (label)
values
    ("News");

insert into
    category (label)
values
    ("Discovery");

insert into
    category (label)
values
    ("Health");

insert into
    category (label)
values
    ("Foods");

insert into
    category (label)
values
    ("Education");

INSERT into
    human_verification_query (body)
VALUES
    ("hathara deken guna karama kiyada
");


INSERT into
    article (
        author_id,
        title,
        description,
        created,
        body
    )
VALUES
    (
        1,

        "Python Crash Course",

        "No Starch Press and the No Starch Press logo are registered trademarks of No Starch Press, Inc. Other
        product and company names mentioned herein may be the trademarks of their respective owners.",

        "2024-12-06 12:34:12",

        "No Starch Press and the No Starch Press logo are registered trademarks of No Starch Press, Inc. Other
        product and company names mentioned herein may be the trademarks of their respective owners. Rather
        than use a trademark symbol with every occurrence of a trademarked name, we are using the names only
        in an editorial fashion and to the benefit of the trademark owner, with no INTEGERention of infringement of the
        trademark.
        The information in this book is distributed on an “As Is” basis, without warranty. While every precaution
        has been taken in the preparation of this work, neither the author nor No Starch Press, Inc. shall have any
        liability to any person or entity with respect to any loss or damage caused or alleged to be caused directly or
        indirectly by the information contained in it No Starch Press and the No Starch Press logo are registered trademarks of No Starch Press, Inc. Other
        product and company names mentioned herein may be the trademarks of their respective owners.
        No Starch Press and the No Starch Press logo are registered trademarks of No Starch Press, Inc. Other
        product and company names mentioned herein may be the trademarks of their respective owners. Rather
        than use a trademark symbol with every occurrence of a trademarked name, we are using the names only
        in an editorial fashion and to the benefit of the trademark owner, with no INTEGERention of infringement of the
        trademark.
        The information in this book is distributed on an “As Is” basis, without warranty. While every precaution
        has been taken in the preparation of this work, neither the author nor No Starch Press, Inc. shall have any
        liability to any person or entity with respect to any loss or damage caused or alleged to be caused directly or
        indirectly by the information contained in it"
    );


INSERT into
    article (
        author_id,
        title,
        description,
        created,
        body
    )
VALUES
    (
        2,

        "New Technologies of 2023",

        "As of the 2023 comming to an end. Here's the most revolutionize tech INTEGERroduced in this year",

        "2023-12-06 12:44:42",

        "No Starch Press and the No Starch Press logo are registered trademarks of No Starch Press, Inc. Other
        product and company names mentioned herein may be the trademarks of their respective owners. Rather
        than use a trademark symbol with every occurrence of a trademarked name, we are using the names only
        in an editorial fashion and to the benefit of the trademark owner, with no INTEGERention of infringement of the
        trademark.
        The information in this book is distributed on an “As Is” basis, without warranty. While every precaution
        has been taken in the preparation of this work, neither the author nor No Starch Press, Inc. shall have any
        liability to any person or entity with respect to any loss or damage caused or alleged to be caused directly or
        indirectly by the information contained in it No Starch Press and the No Starch Press logo are registered trademarks of No Starch Press, Inc. Other
        product and company names mentioned herein may be the trademarks of their respective owners.
        No Starch Press and the No Starch Press logo are registered trademarks of No Starch Press, Inc. Other
        product and company names mentioned herein may be the trademarks of their respective owners. Rather
        than use a trademark symbol with every occurrence of a trademarked name, we are using the names only
        in an editorial fashion and to the benefit of the trademark owner, with no INTEGERention of infringement of the
        trademark.
        The information in this book is distributed on an “As Is” basis, without warranty. While every precaution
        has been taken in the preparation of this work, neither the author nor No Starch Press, Inc. shall have any
        liability to any person or entity with respect to any loss or damage caused or alleged to be caused directly or
        indirectly by the information contained in it"
    );


INSERT into
    article (
        author_id,
        title,
        description,
        created,
        body
    )
VALUES
    (
        3,

        "Sri Lankan's new leap of faith",

        "People of Sri Lanka has voted for a new party after 2022 economic crisis",

        "2024-12-06 12:34:12",

        "No Starch Press and the No Starch Press logo are registered trademarks of No Starch Press, Inc. Other
        product and company names mentioned herein may be the trademarks of their respective owners. Rather
        than use a trademark symbol with every occurrence of a trademarked name, we are using the names only
        in an editorial fashion and to the benefit of the trademark owner, with no INTEGERention of infringement of the
        trademark.
        The information in this book is distributed on an “As Is” basis, without warranty. While every precaution
        has been taken in the preparation of this work, neither the author nor No Starch Press, Inc. shall have any
        liability to any person or entity with respect to any loss or damage caused or alleged to be caused directly or
        indirectly by the information contained in it No Starch Press and the No Starch Press logo are registered trademarks of No Starch Press, Inc. Other
        product and company names mentioned herein may be the trademarks of their respective owners.
        No Starch Press and the No Starch Press logo are registered trademarks of No Starch Press, Inc. Other
        product and company names mentioned herein may be the trademarks of their respective owners. Rather
        than use a trademark symbol with every occurrence of a trademarked name, we are using the names only
        in an editorial fashion and to the benefit of the trademark owner, with no INTEGERention of infringement of the
        trademark.
        The information in this book is distributed on an “As Is” basis, without warranty. While every precaution
        has been taken in the preparation of this work, neither the author nor No Starch Press, Inc. shall have any
        liability to any person or entity with respect to any loss or damage caused or alleged to be caused directly or
        indirectly by the information contained in it"
    );



INSERT into
    article (
        author_id,
        title,
        description,
        created,
        body
    )
VALUES
    (
        4,

        "Quantem World",

        "Stupidly tiny yet wonderfull word with new kind of mechanisam",

        "2024-12-06 12:34:12",

        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Eligendi facere neque minima sequi excepturi mollitia delectus fugiat soluta dignissimos ab quia dolorum sapiente fugit facilis earum illum architecto sint, repellendus iste tenetur adipisci. Minima esse, fuga corrupti doloremque odit cupiditate eveniet quia nam non tempore quo fugiat nemo minus, doloribus omnis magni. Minus, excepturi? Velit necessitatibus numquam aliquam reprehenderit aliquid illo cum magnam nostrum sit placeat dignissimos molestias alias quia maiores asperiores animi architecto facere autem aut, ipsam iusto. Non sed mollitia rerum totam officiis fugit rem suscipit in quis excepturi deleniti, quo, voluptates fuga nulla, distinctio animi reiciendis incidunt est impedit cumque expedita optio obcaecati deserunt ad! Quisquam perferendis itaque maxime deleniti corrupti iusto. Maxime corrupti laudantium accusantium consectetur facilis eum expedita illum quidem aliquid. Magni unde ratione fugiat nesciunt consequuntur illum alias sint sunt aliquid cum! Nobis iusto id animi pariatur, corporis doloribus adipisci praesentium ipsa reprehenderit consequatur obcaecati alias suscipit aut quidem voluptas fugit totam. Eius autem voluptates dolor facere quis dolores mollitia sequi, corporis, sit ducimus minus et tempora cum delectus quae quidem sapiente! Cumque sint amet reprehenderit temporibus commodi esse itaque veniam! Eligendi explicabo culpa enim natus praesentium ab velit aliquam eaque, dicta ipsam nihil alias repellat iure. A quam aliquam illo, architecto magnam commodi quaerat deleniti dolorem aspernatur labore porro in esse iure rem itaque nihil cumque dolores nemo. Similique, reiciendis. Qui quis totam veniam cupiditate voluptatem, voluptatibus rem reiciendis amet consectetur delectus tempore? Vel, eveniet quibusdam dolorum cumque qui sed rem obcaecati laborum magnam? Amet in ut, commodi repudiandae quod assumenda aspernatur nobis deleniti repellendus rem! Ducimus non facere, aut voluptatum necessitatibus quas autem ullam harum possimus error, veniam alias reprehenderit at, voluptates laudantium. Optio reprehenderit, sed eaque nobis esse veritatis quidem. Ipsam sit unde ducimus eius beatae doloribus quas itaque vero id!"
    );

 
INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (1, "8");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (1, "ata");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (1, "atayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (1, "atai
");

INSERT into
    human_verification_query (body)
VALUES
    ("pahata thunak ekathu karama kiyada
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (2, "8");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (2, "ata");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (2, "atayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (2, "atai
");

INSERT into
    human_verification_query (body)
VALUES
    ("wissa deken beduwama kiyada
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (3, "10");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (3, "dahaya");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (3, "dahayayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (3, "dahayai
");

INSERT into
    human_verification_query (body)
VALUES
    ("thuna pahen guna karama kiyada
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (4, "15");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (4, "pahalawa");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (4, "pahalowa");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (4, "pahalawayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (4, "pahalowayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (4, "pahalawai");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (4, "pahalowai
");

INSERT into
    human_verification_query (body)
VALUES
    ("thunata dekak ekathu karama kiyada
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (5, "5");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (5, "paha");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (5, "pahayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (5, "pahai
");

INSERT into
    human_verification_query (body)
VALUES
    ("ekai pahayi ekathu karama kiyada
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (6, "6");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (6, "haya");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (6, "hayayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (6, "hayai
");

INSERT into
    human_verification_query (body)
VALUES
    ("thuna deken guna karama kiyada
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (7, "6");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (7, "haya");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (7, "hayayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (7, "hayai
");

INSERT into
    human_verification_query (body)
VALUES
    ("hathara deken guna karama kiyada
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (8, "8");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (8, "ata");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (8, "atayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (8, "atai
");

INSERT into
    human_verification_query (body)
VALUES
    ("thunata dekak ekathu karama kiyada 
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (9, "5");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (9, "paha");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (9, "pahayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (9, "pahai
");

INSERT into
    human_verification_query (body)
VALUES
    ("haya deken beduwama kiyada
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (10, "3");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (10, "thuna");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (10, "thunayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (10, "thunai
");

INSERT into
    human_verification_query (body)
VALUES
    ("dolahata thunak ekathu karama kiyada
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (11, "15");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (11, "pahalawa");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (11, "pahalowa");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (11, "pahalawayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (11, "pahalowayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (11, "pahalawai");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (11, "pahalowai
");

INSERT into
    human_verification_query (body)
VALUES
    ("dekeyi thuneyi paheyi ekathuwa kiyada
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (12, "10");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (12, "dahaya");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (12, "dahayayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (12, "dahayai
");

INSERT into
    human_verification_query (body)
VALUES
    ("pahayi thunayi ekathu karama kiyada
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (13, "8");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (13, "ata");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (13, "atayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (13, "atai
");

INSERT into
    human_verification_query (body)
VALUES
    ("ekayi dekayi ekathu karama kiyada
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (14, "3");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (14, "thuna");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (14, "thunayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (14, "thunai
");

INSERT into
    human_verification_query (body)
VALUES
    ("deke ewa dekak kiyada
");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (15, "4");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (15, "hathara");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (15, "hatharayi");

INSERT into
    human_verification_query_answer (id, anwser)
VALUES
    (15, "hatharai");

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        1,
        "kamal weerasinghe",
        "1960-11-02",
        "kamal.weerasinghe@gmail.com",
        "bc910456eb2568ab9e9332635dab87e55615708533de1d1f965df7cff4df6acd",
        "434",
        "male",
        "kamal.weerasinghe",
        "6b33ff024035661cb9b9cc34908bdee6cb1bb1419fc2040ca3cf1af11d93ffcc"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        2,
        "nimal weerasinghe",
        "1961-11-02",
        "nimal.weerasinghe@gmail.com",
        "83cc984135d566c931bf8093cd33fad8be41b9f6ada43a78201a390200a042c7",
        "182",
        "male",
        "nimal.weerasinghe",
        "84e6a778be55682ff815a69f54cccc2613a02b1479a41a45cfd1c801906600cb"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        3,
        "wimal weerasinghe",
        "1962-11-02",
        "wimal.weerasinghe@gmail.com",
        "3cba93c0f807ffc3c1b7cb6533b1d7ec41112ddc45530c1064e7d548db7e2953",
        "054",
        "male",
        "wimal.weerasinghe",
        "13f8ee2c0d9dde471fa7b9ba5a74760e297f3dee2ea57116f108b45829cef900"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        4,
        "sunimal weerasinghe",
        "1963-11-02",
        "sunimal.weerasinghe@gmail.com",
        "c09d4b12a8cb80251bf7947db201c24b7fe11755e9b12c5159fe3fa78c37844b",
        "062",
        "male",
        "sunimal.weerasinghe",
        "813cb611a5c83db7cbb25e184a32587e99b0876149c27ca350b5fac1e67088d2"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        5,
        "supun weerasinghe",
        "1964-11-02",
        "supun.weerasinghe@gmail.com",
        "3cf93d368882fcbaab5bea76248e75fabab93d9a0ff182396e38fb52f19167a6",
        "905",
        "male",
        "supun.weerasinghe",
        "b607795e462df84ff2f9626e57cd254547b03b2bde86dfe73dd4ee8caa0bf050"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        6,
        "namal weerasinghe",
        "1965-11-02",
        "namal.weerasinghe@gmail.com",
        "4e54f053e1e6a593598e6d4b80c3aeeaf9d0fb68b205fcc6198a47da6493ab05",
        "959",
        "male",
        "namal.weerasinghe",
        "843d4098b59455975968fe3ca72384117bf7b2f6e41101fd805789c26e459612"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        7,
        "amal weerasinghe",
        "1966-11-02",
        "amal.weerasinghe@gmail.com",
        "68de68fe0b9899df151df379991a635fde91d0b31278ec4df4d8dd7e78dc8756",
        "030",
        "male",
        "amal.weerasinghe",
        "f09dcb7fde364864c8cbf1a626af13d44925285a2eebf7bfaccd6bf12bc3820f"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        8,
        "sugath weerasinghe",
        "1967-11-02",
        "sugath.weerasinghe@gmail.com",
        "8779ddc80f221fef3a14642c5ffb3ebeeb068fce5c4d1241f5d79be76dec8fb6",
        "946",
        "male",
        "sugath.weerasinghe",
        "0baa26c7c151c31ed2f6160f3da2a6041d5ef04c7e570c86dc186bfd70621055"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        9,
        "kamal gamage",
        "1968-11-02",
        "kamal.gamage@gmail.com",
        "b267d08908b2522b4db3c6531fe1fe1e807a575b572c9d7f3fe0062b01927b2d",
        "086",
        "male",
        "kamal.gamage",
        "8589bf84befb5578ca2115447a7104c07ac0283cf244f3dc7d9da64db0aec181"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        10,
        "nimal gamage",
        "1969-11-02",
        "nimal.gamage@gmail.com",
        "deaeb8ad99a5eab42093b9992dafd35cbff6ad060572b0bb83b111a391cb8fc7",
        "084",
        "male",
        "nimal.gamage",
        "27a9bccaf55504f6a1425cce70b4c18995057ae6bdfb6d74ffe50dc120658d1a"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        11,
        "wimal gamage",
        "1970-11-02",
        "wimal.gamage@gmail.com",
        "74ace3db79712fe18a1f6fb4ddf7e1226b9737220cc8bf1b7c2948a0dfdf85eb",
        "927",
        "male",
        "wimal.gamage",
        "1f0efa1ddad2c88352b419c2e7cbbbac7d094e7f8b6cb4250141e6666b9d9705"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        12,
        "sunimal gamage",
        "1971-11-02",
        "sunimal.gamage@gmail.com",
        "b446d75d1b64e39d9a7c684ceba86f67d41689a3f9d0ae225c7e6869ada06c02",
        "916",
        "male",
        "sunimal.gamage",
        "7e06b5fafcfbb854ffcddb56c1c2f01438966d9cdade6ead78661ae3da770b8e"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        13,
        "supun gamage",
        "1972-11-02",
        "supun.gamage@gmail.com",
        "2f8ce1dcf20904643204af50340a7198e741f0a8c1b035a235a949701db4eb32",
        "720",
        "male",
        "supun.gamage",
        "b183aa21932a68abf8a6f4f745c2b74e30d081b9c961864e56e8efe3687a46fc"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        14,
        "namal gamage",
        "1973-11-02",
        "namal.gamage@gmail.com",
        "ab3660decc68755c7da576ef3a5336a9da91f80cbb8fb995f30868dbd4609b0d",
        "434",
        "male",
        "namal.gamage",
        "d6905f7fab62a1140f79a16ce74e7ef6bc84ad5d4fe2a56f3c4dc11578aadd28"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        15,
        "amal gamage",
        "1974-11-02",
        "amal.gamage@gmail.com",
        "0302467b88fa3b63c86590c0f03a57f4aad1cdbdd6f9b85673b78b8a7b2e73d8",
        "551",
        "male",
        "amal.gamage",
        "a037d0305b691e9b42a3f41ef751e9dcf9407a71448fb56212a3f9d7f3ccd6ac"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        16,
        "sugath gamage",
        "1975-11-02",
        "sugath.gamage@gmail.com",
        "462d6c07bce80ea494ba9e632c81e2fdb0f767b93af2debfaacdd97a251993f1",
        "436",
        "male",
        "sugath.gamage",
        "45e6e3f240f959cbb696a68ecaeb5dc2367588ac96808f3b5f9e39e7920b4fbc"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        17,
        "kamal anuruddha",
        "1976-11-02",
        "kamal.anuruddha@gmail.com",
        "4f6c31c41fa0869b3c26fb0eea1293a793116b468d140f9a3c95420d476015d1",
        "649",
        "male",
        "kamal.anuruddha",
        "63a4c9da85a3aca747849b021b81faf6f6c16245e463209055d04640f2e34eb3"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        18,
        "nimal anuruddha",
        "1977-11-02",
        "nimal.anuruddha@gmail.com",
        "059a563997def851aec54fdb4d1fe04c48c6cc62a427ecfead1c14e52dab011e",
        "800",
        "male",
        "nimal.anuruddha",
        "d89dc2e27fed623a2c6b3f2a17e3f962dff4c016dc4a050ac2d0560dad0c6e4e"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        19,
        "wimal anuruddha",
        "1978-11-02",
        "wimal.anuruddha@gmail.com",
        "7dc118b9132ccb899fb6e0f07173d7baa7e04c8762c9946c29b4a6a6907097b8",
        "689",
        "male",
        "wimal.anuruddha",
        "ed2ddfebf6c4e4da02890cad43112bf928a7ebd213746bc5f7cec1319132a339"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        20,
        "sunimal anuruddha",
        "1979-11-02",
        "sunimal.anuruddha@gmail.com",
        "4cda5d35bccb409b9ff522f0deddc6b729a10431ceff1bb8a4539792f7f36ec8",
        "732",
        "male",
        "sunimal.anuruddha",
        "c643cf9a0893333747b9bf73f7d59ca9c48ab45fd46415b28144a6bc13c98bbc"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        21,
        "supun anuruddha",
        "1980-11-02",
        "supun.anuruddha@gmail.com",
        "2738da560aa9a1f49a993675be8a244614b547b87f71ea8970416babc0895b03",
        "447",
        "male",
        "supun.anuruddha",
        "87cb4f723842010ef443d0e0e86814440c5bcc49c2f54ca8ef9444f4b7384617"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        22,
        "namal anuruddha",
        "1981-11-02",
        "namal.anuruddha@gmail.com",
        "f5174ec23075e1a4260bdb55b2fe5cf723598042b24b6d87fd80663854090f7b",
        "479",
        "male",
        "namal.anuruddha",
        "1fdb2db4c46291bd44046708d36a45ca4e1cd8d66723c87ba611f8b4f0ef67dc"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        23,
        "amal anuruddha",
        "1982-11-02",
        "amal.anuruddha@gmail.com",
        "27f0c0c8a46265058861de1f2f7a2b79ad252e9aa08c87b0bad633307c9e745a",
        "415",
        "male",
        "amal.anuruddha",
        "667f17e5b1b051984ca4d8de6b96f397f3cd3ec09272bc98302dee1227db5c14"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        24,
        "sugath anuruddha",
        "1983-11-02",
        "sugath.anuruddha@gmail.com",
        "f6133af2c5f958a5da8a42c6b6817dec1310007b220e7deecce992fa17ff63bd",
        "816",
        "male",
        "sugath.anuruddha",
        "b1d8f2081b4e2f1d52db479d74b3089faa5d425a1997f6c6e08c5b950c35e400"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        25,
        "kamal munasinghe",
        "1984-11-02",
        "kamal.munasinghe@gmail.com",
        "aaaec02fa4a9d9c97cc2e6bedb80ca8b3a8e0f9e7196e4b45f873fddb8da378b",
        "564",
        "male",
        "kamal.munasinghe",
        "43bb4068f72469ec924130e63d2aac8f8db172a53b1576bf33ad1d275200b812"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        26,
        "nimal munasinghe",
        "1985-11-02",
        "nimal.munasinghe@gmail.com",
        "8903c47f44d99f861366c7098956c22ab68dfd7e73773297cc2ce5eefe5ddc2f",
        "706",
        "male",
        "nimal.munasinghe",
        "e6b52a39fa9ec91dc561807852919face435dd14d79a54447165a4056ce94be4"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        27,
        "wimal munasinghe",
        "1986-11-02",
        "wimal.munasinghe@gmail.com",
        "ecfea320df99eb60dcfe8d24b8cb9d83c99f17bc32f87f5fee897326650bab5e",
        "503",
        "male",
        "wimal.munasinghe",
        "5248f6d0bf36618566473d51f986c32e90802c5ddd364e42bd14909389f43f82"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        28,
        "sunimal munasinghe",
        "1987-11-02",
        "sunimal.munasinghe@gmail.com",
        "b05d0d30fa925869e03c748f5067c83cc27c3ec07a0ca57472abdee32731ae0c",
        "495",
        "male",
        "sunimal.munasinghe",
        "eec711e6ba7f82bfa1ffd82689f58f5008ffd3bbed9c59bc90857a5a62659ed1"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        29,
        "supun munasinghe",
        "1988-11-02",
        "supun.munasinghe@gmail.com",
        "a9754113440efd17cfe2b80db1c6bda1930fac2678b90981c77d0556cfcacdd6",
        "287",
        "male",
        "supun.munasinghe",
        "97ed56528124dad57de104bf30971e7845324b961c05e8b690a39bbe7683584f"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        30,
        "namal munasinghe",
        "1989-11-02",
        "namal.munasinghe@gmail.com",
        "f66d51efe4efa5922802f038e4f8c3f95582c8f075e5d90b94ab04818723af0a",
        "312",
        "male",
        "namal.munasinghe",
        "4db09155640246fec12d0b508453e4cceda65b10d39046a13a7e52c255c3d23e"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        31,
        "amal munasinghe",
        "1990-11-02",
        "amal.munasinghe@gmail.com",
        "a3a9068940e81966762c8e028cbf9f33c52dfcb3e7beaea7ed9411ef86c2c022",
        "168",
        "male",
        "amal.munasinghe",
        "30f5b5df4a816877ee0f6748458848c463e2a8ef949ead97578ab6e655e1d246"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        32,
        "sugath munasinghe",
        "1991-11-02",
        "sugath.munasinghe@gmail.com",
        "641d030e84e9317ee8f0ba5ef0fcf2f9153843772468a7851ad24f6c90aa7bae",
        "967",
        "male",
        "sugath.munasinghe",
        "0d8e614bf18f5c65b095c0c02a9fff16f8728e9f10154a945ecaa9b1007476bd"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        33,
        "kamal hewage",
        "1992-11-02",
        "kamal.hewage@gmail.com",
        "469fdb237c375b4e6757048f6f8591b184cc2d81b5f27dc5dc271113b3411c38",
        "891",
        "male",
        "kamal.hewage",
        "221f717d3d52a6edc83e9bb807666b38e2cdc429794ea3e4c96d7abdc85ecb27"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        34,
        "nimal hewage",
        "1993-11-02",
        "nimal.hewage@gmail.com",
        "d51faed0afb00017f41be1cb26d847174860e900bc11c7ec74bd6fe3f6a34c7c",
        "226",
        "male",
        "nimal.hewage",
        "c67453af595d83efc913a54edb10e1577616a19328afb6f9364178c5b1fdd127"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        35,
        "wimal hewage",
        "1994-11-02",
        "wimal.hewage@gmail.com",
        "3ff10d7ad72a7aef513858e63dc825fea48a5c4e290202a4dd8acb3f7091e90c",
        "473",
        "male",
        "wimal.hewage",
        "5e3d6185a07c91240851be0a7afee41cb84111ad3a46ab653a507c283ea124fb"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        36,
        "sunimal hewage",
        "1995-11-02",
        "sunimal.hewage@gmail.com",
        "f3cd10a1db8f466866b140d54ec5e9545396361736d25c78e014c29be24f13a2",
        "595",
        "male",
        "sunimal.hewage",
        "b28334b59ae329a14e608fdf5a07b9841427d956d859851f4144a61708ac3d30"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        37,
        "supun hewage",
        "1996-11-02",
        "supun.hewage@gmail.com",
        "7bfaa64ef59e8de1a363411cea5b7d7153b5529ae9e65b483eb1d37009f82ed2",
        "968",
        "male",
        "supun.hewage",
        "e6a73bb795c8bf93158d0e9f67383886094175426e948248addf215d9af95986"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        38,
        "namal hewage",
        "1997-11-02",
        "namal.hewage@gmail.com",
        "381520f9c5d43941fb4398e6fe8dbbc9b93cf4689d9645134c26d9922d596ecf",
        "497",
        "male",
        "namal.hewage",
        "973bebb0feb12353c53fc89ba7bfcc18ea5fb8ebb695d468e50b7292b0ed6e3a"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        39,
        "amal hewage",
        "1998-11-02",
        "amal.hewage@gmail.com",
        "e6f91dd245cbc88ad0f1cdd6a44d50c718130ed10717d94e7f9138ef7754d8a5",
        "181",
        "male",
        "amal.hewage",
        "591f0ac9d4f5eadbad5eeb6e050ac25022531a4b48b08fdfb263057b5b57b43d"
    );

insert into
    user (
        id,
        fullname,
        dob,
        email,
        phone_number,
        phone_number_last_digits,
        gender,
        username,
        password
    )
values
    (
        40,
        "sugath hewage",
        "1999-11-02",
        "sugath.hewage@gmail.com",
        "0e7ee89b094583f59bb3805671489a6e04a6987aba4ae2e000ba6602a2ce0395",
        "598",
        "male",
        "sugath.hewage",
        "71e7a2bf081ee1b512e0c4fc7fef71528950852ff0dd08b0824532625de8687a"
    );