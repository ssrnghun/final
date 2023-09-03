package com.final1.logic;

import java.util.Comparator;

class NameComparator implements Comparator<AccountDTO> {
    @Override
    public int compare(AccountDTO f1, AccountDTO f2) 
    {
        return f1.getGivemember().compareTo(f2.getGivemember());
    }
}