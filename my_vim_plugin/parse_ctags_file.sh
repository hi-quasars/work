#!/bin/bash

function parse_ctag()
{
    ctag=$1
    awk -F'\t' '                    \
        BEGIN       {               \
                        stypestr="macro_enum_struct_union_typedef_variable_function";  \
                        stagtypestr="d_g_s_u_t_v_f";                \
                        typenum=split(stypestr, typestr, "_");      \
                        split(stagtypestr, tagtypestr, "_");        \
                        for(i = 1; i <= typenum; i++){  \
                            tags[typestr[i]] = "";      \
                            tagsindex[tagtypestr[i]] = typestr[i];   \
                        }   \
                    } \
        /^[^\!]+/   {                       \
                        print $1,$4;        \
                        tag_name = $1;      \
                        
                        tag_type = $4;      \
                        if( tags[tagsindex[tag_type]] == "" ){      \
                            tags[tagsindex[tag_type]] = tag_name;   \
                        }else{  \
                            tags[tagsindex[tag_type]] = tags[tagsindex[tag_type]] "" ";" ""  tag_name;  \
                        }   \

                    }  \
        END         {  \
                        print "========================"
                        for(i = 1; i <= typenum; i++){  \
                            print typestr[i] "" ":" "" tags[typestr[i]];    \
                        }   \
                    }  \
    ' $ctag
}


parse_ctag $1
