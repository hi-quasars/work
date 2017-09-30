#!/bin/bash

function parse_ctag()
{
    ctag=$1
    awk -F'\t' '                    \
        BEGIN       {               \
                        stypestr="#Macro_#Enum_#Struct_#Union_#Typedef_#Variable_#Function";  \
                        stagtypestr="d_g_s_u_t_v_f";                \
                        typenum=split(stypestr, typestr, "_");      \
                        split(stagtypestr, tagtypestr, "_");        \
                        for(i = 1; i <= typenum; i++){  \
                            tags[typestr[i]] = "";      \
                            tagsindex[tagtypestr[i]] = typestr[i];   \
                        }   \
                    } \
        /^[^\!]+/   {                       \
                        tag_name = $1;      \
                        tag_type = $4;      \
                        if( tags[tagsindex[tag_type]] == "" ){      \
                            tags[tagsindex[tag_type]] = tag_name;   \
                        }else{  \
                            tags[tagsindex[tag_type]] = tags[tagsindex[tag_type]] "" "\n" ""  tag_name;  \
                        }   \
                    }  \
        END         {  \
                        result = "";    \
                        for(i = 1; i <= typenum; i++){      \
                            result = result "" typestr[i] "" "\n" "" tags[typestr[i]] "" "\n";    \
                        }   \
                        print result;    \
                    }  \
    ' $ctag
}


parse_ctag $1
