defmodule FanCan.Core.Utils do
    def states do
        [:AL,:AK,:AZ,:AR,:CA,:CO,:CT,:DE,:FL,:GA,:HI,:ID,:IL,:IN,:IA,:KS,:KY,:LA,:ME,:MD,:MA,
        :MI,:MN,:MS,:MO,:MT,:NE,:NV,:NH,:NJ,:NM,:NY,:NC,:ND,:OH,:OK,:OR,:PA,:RI,:SC,:SD,:TN,
        :TX,:UT,:VT,:VA,:WA,:WV,:WI,:WY,:AS,:GU,:MP,:PR,:VI,:DC]
    end

    def state_names do
        ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia",
        "Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts",
        "Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico",
        "New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina",
        "South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
    end

    def seats do
        [:senator, :judge, :legislator, :comptroller, :mayor, :governor, :sherrif, :assessor]
    end

    def attachment_types do
        [:image, :pdf]
    end
end