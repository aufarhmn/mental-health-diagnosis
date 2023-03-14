; Tugas Mata Kuliah Kecerdasan Buatan
; Implementasi Expert System dengan CLIPS
; Oleh: Aufa Nasywa Rahman - 21/475255/TK/52454

; Inisiasi/Awalan Program untuk welcome screen
(defrule Init
    (initial-fact)
    =>
    (printout t crlf "=========================================================="
                crlf "        Expert System for Diagnosing Mental Health        "
                crlf ""
                crlf "                Oleh: Aufa Nasywa Rahman                  "
                crlf "                   21/475255/TK/52454                     "
                crlf "=========================================================="
                crlf ""
                crlf "Description:"
                crlf "Expert System yang bertujuan untuk diagnosis awal mengenai penyakit mental"
                crlf ""
                crlf "Silakan ketik 1 untuk melanjutkan dan 0 untuk keluar" crlf)
    (bind ?input (read))
        (if (= ?input 1)
            then (assert (Start true))
        else (= ?input 0)
            then (printout t crlf "Semoga sehat selalu!" crlf)
        )
)

; Rule gejala umum penyakit mental
(defrule GejalaUmum
    (Start true)
    =>
    (printout t crlf "Berikut adalah gejala umum bagi penderita penyakit mental:"
                crlf "1. Stress yang berkelanjutan"
                crlf "2. Tidak bersemangat dalam beraktivitas"
                crlf "3. Kelelahan yang berkelanjutan"
                crlf "Apakah Anda memiliki gejala tersebut?"
                crlf "1: Ya"
                crlf "0: Tidak" crlf)
    (bind ?input (read))
        (if (= ?input 1)
            then (assert (GejalaUmum true))
        else (= ?input 0)
            then (printout t crlf "Anda tidak terindikasi memiliki masalah kesehatan mental, Tetap jaga kesehatan!" crlf)
        )
)

; Rule untuk filter antara depresi berat, gangguan kecemasan umum, dan bipolar
(defrule Filter1
    (GejalaUmum true)
    =>
    (printout t crlf "Berikut gejala yang mungkin muncul pada diri Anda:"
                crlf "1. Perasaan sedih dan cemas yang berkelanjutan"
                crlf "2. Sulit Tidur"
                crlf "Apakah Anda memiliki gejala tersebut?"
                crlf "1: Ya"
                crlf "0: Tidak" crlf)
    (bind ?input (read))
        (if (= ?input 1)
            then (assert (Filter1 true))
        else (= ?input 0)
            then (assert (Filter1 false))
        )
)

; Rule untuk filter antara depresi berat dan gangguan kecemasan umum
(defrule Filter2
    (Filter1 true)
    =>
    (printout t crlf "Berikut gejala yang mungkin muncul pada diri Anda:"
                crlf "1. Tidak ada ambisi"
                crlf "2. Kehilangan ketertarikan"
                crlf "3. Kehilangan nafsu"
                crlf "4. Gelisah"
                crlf "5. Sulit berkonsentrasi"
                crlf "6. Gangguan emosi"
                crlf "7. Otot tidak rileks"
                crlf "Apakah Anda memiliki gejala tersebut?"
                crlf "1: Ya"
                crlf "0: Tidak" crlf)
    (bind ?input (read))
        (if (= ?input 1)
            then (assert (Filter2 true))
        else (= ?input 0)
            then (assert (Filter2 false))
        )
)

; Rule depresi berat
(defrule DepresiBerat
    (Filter2 true)
    =>
    (printout t crlf "Apakah anda pernah befikir untuk menyakiti diri sendiri?"
                crlf "1: Ya"
                crlf "0: Tidak" crlf)
    (bind ?input (read))
        (if (= ?input 1)
            then (printout t crlf "Anda didagnosis mengalami depresi berat, segera hubungi psikiater!" crlf)
        else (= ?input 0)
            then (assert (DepresiBerat false))
        )
)

; Rule gangguan kecemasan umum
(defrule GangguanKecemasanUmum
    (or (DepresiBerat false) 
        (Bipolar false)
        (Filter3 false)
        (PTSD false))
    =>
    (printout t crlf "Anda didiagnosis mengalami gangguan kecemasan umum, silakan konsultasikan dengan psikiater" crlf)
)

; Rule bipolar
(defrule Bipolar
    (Filter2 false)
    =>
    (printout t crlf "Berikut gejala yang mungkin muncul pada diri Anda:"
                crlf "1. Suasana hati berubah-ubah"
                crlf "2. Kepercayaan diri menurun"
                crlf "3. Pikiran tidak stabil"
                crlf "Apakah Anda memiliki gejala tersebut?"
                crlf "1: Ya"
                crlf "0: Tidak" crlf)
    (bind ?input (read))
        (if (= ?input 1)
            then (printout t crlf "Anda didiagnosis mengalami bipolar, segera hubungi psikiater!" crlf)
        else (= ?input 0)
            then (assert (Bipolar false))
        )
)

; Rule skizofrenia
(defrule Skizofrenia
    (Filter1 false)
    =>
    (printout t crlf "Berikut gejala yang mungkin muncul pada diri Anda:"
                crlf "1. Halusinasi"
                crlf "2. Delusi"
                crlf "3. Gangguan bicara dan/atau perilaku"
                crlf "4. Ekspresi emosional yang berkurang"
                crlf "5. Keinginan untuk menghindari interaksi"
                crlf "Apakah Anda memiliki gejala tersebut?"
                crlf "1: Ya"
                crlf "0: Tidak" crlf)
    (bind ?input (read))
        (if (= ?input 1)
            then (printout t crlf "Anda didiagnosis mengalami skizofrenia, segera hubungi psikiater!" crlf)
        else (= ?input 0)
            then (assert (Skizofrenia false))
        )
)

; Rule untuk filter OCD dan PTSD
(defrule Filter3
    (Skizofrenia false)
    =>
    (printout t crlf "Apakah Anda memiliki kecenderungan untuk memiliki pemikiran yang menggangu?"
                crlf "1: Ya"
                crlf "0: Tidak" crlf)
    (bind ?input (read))
        (if (= ?input 1)
            then (assert (Filter3 true))
        else (= ?input 0)
            then (assert (Filter3 false))
        )
)

; Rule OCD
(defrule ObsessiveCompulsive
    (Filter3 true)
    =>
    (printout t crlf "Apakah Anda memiliki kecenderungan untuk melakukan tindakan yang repetitif dengan tujuan melawan pikiran negatif tersebut?"
                crlf "1: Ya"
                crlf "0: Tidak" crlf)
    (bind ?input (read))
        (if (= ?input 1)
            then (printout t crlf "Anda didiagnosis mengalami Obsessive Compulsive Disorder, silakan konsultasikan dengan psikiater" crlf)
        else (= ?input 0)
            then (assert (ObsessiveCompulsive false))
        )
)

; Rule PTSD
(defrule PTSD
    (ObsessiveCompulsive false)
    =>
    (printout t crlf "Apakah pikiran tersebut disebabkan oleh trauma pada masa lampau?"
                crlf "1: Ya"
                crlf "0: Tidak" crlf)
    (bind ?input (read))
        (if (= ?input 1)
            then (printout t crlf "Anda didiagnosis mengalami Post Traumatic Stress Disorder, segera hubungi psikiater!" crlf)
        else (= ?input 0)
            then (assert (PTSD false))
        )
)