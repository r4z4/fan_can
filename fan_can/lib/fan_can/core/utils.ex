defmodule FanCan.Core.Utils do
    def states do
        [:AL,:AK,:AZ,:AR,:CA,:CO,:CT,:DE,:FL,:GA,:HI,:ID,:IL,:IN,:IA,:KS,:KY,:LA,:ME,:MD,:MA,
        :MI,:MN,:MS,:MO,:MT,:NE,:NV,:NH,:NJ,:NM,:NY,:NC,:ND,:OH,:OK,:OR,:PA,:RI,:SC,:SD,:TN,
        :TX,:UT,:VT,:VA,:WA,:WV,:WI,:WY,:AS,:GU,:MP,:PR,:VI,:DC]
    end

    def state_names do
        [:Alabama,:Alaska,:Arizona,:Arkansas,:California,:Colorado,:Connecticut,:Delaware,:Florida,:Georgia,
        :Hawaii,:Idaho,:Illinois,:Indiana,:Iowa,:Kansas,:Kentucky,:Louisiana,:Maine,:Maryland,:Massachusetts,
        :Michigan,:Minnesota,:Mississippi,:Missouri,:Montana,:Nebraska,:Nevada,:New_Hampshire,:New_Jersey,:New_Mexico,
        :New_York,:North_Carolina,:North_Dakota,:Ohio,:Oklahoma,:Oregon,:Pennsylvania,:Rhode_Island,:South_Carolina,
        :South_Dakota,:Tennessee,:Texas,:Utah,:Vermont,:Virginia,:Washington,:West_Virginia,:Wisconsin,:Wyoming]
    end

    def territories do
        [:American_Samoa, :Guam, :Northern_Mariana_Islands, :Peurto_Rico, :Virgin_Islands, :District_of_Columbia]
    end

    def seats do
        [:Senator, :Judge, :Legislator, :Comptroller, :Mayor, :Governor, :Sherrif, :Board_Member, :Council_Member, :Public_Defender]
    end

    def parties do
        [:Republican, :Democrat, :Independent, :Libertarian, :Other_Party]
    end

    def suffixes do
        [:Sr, :Jr, :III, :II]
    end

    def prefixes do
        [:Mr, :Mrs, :Ms, :Miss, :Dr]
    end

    def no_image do
        "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png"
    end

    def attachment_types do
        [:image, :pdf]
    end
end