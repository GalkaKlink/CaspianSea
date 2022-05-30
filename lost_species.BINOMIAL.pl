use strict;
my $NNN = 31;   #all species in Caspii2
my $KKK = 11;   #lost species

open (OUT, ">>Lost_species.Binomial_pv_families.GOOD_DATA.txt") or die $!;
open (IN, "Caspii2_lost.txt") or die $!;
my $names = <IN>;
while(<IN>) {
    my $str = $_;
    my @all = $str =~ m/\w+/g;
    my $fam = $all[0];
    my $nnn = $all[2];   #sp from family on C2
    my $kkk = $all[1];   #lost sp from family

    my $p_actual = 1;
    my $p_over = 0;
    
    my $min = $nnn;
    if ($KKK<$nnn) {
	$min = $KKK;
    }
    foreach my $k ($kkk..$min) {
	my $c1 = 1;
	my $chisl1 = 1;
	my $znam1 = 1;
	my @chisl1;
	my @znam1;		
	foreach my $l(($k+1)..$KKK) {
	    #$chisl1 = $chisl1*$l;
	    push(@chisl1,$l);
	}
	foreach my $l(1..($KKK-$k)) {
	    #$znam1 = $znam1*$l;
	    push(@znam1,$l);
	}
	if ($#chisl1 != $#znam1) {
	    print "!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
	}
	foreach my $number(0..$#chisl1) {
	    my $ch = $chisl1[$number];
	    my $zn = $znam1[$number];
	    my $ratio = $ch/$zn;
	    $c1 = $c1*$ratio;
	}
	#$c1 = $chisl1/$znam1;
		#print $chisl1."\t".$znam1."\t".$c1."\n";
		
	
	my $c2=1;
	my $chisl2 = 1;
	my $znam2 = 1;
	my @chisl2;
	my @znam2;
	foreach my $l(($nnn-$k+1)..($NNN-$KKK)) {
	    #$chisl2 = $chisl2*$l;
	    push(@chisl2,$l);
	}
	foreach my $l(1..($NNN-$KKK-$nnn+$k)) {
	    #$znam2 = $znam2*$l;
	    push(@znam2,$l);
	}
	if ($#chisl2 != $#znam2) {
	    print "!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
	}
	foreach my $number(0..$#chisl2) {
	    my $ch = $chisl2[$number];
	    my $zn = $znam2[$number];
	    my $ratio = $ch/$zn;
	    $c2 = $c2*$ratio;
	}
	
	#$c2 = $chisl2/$znam2;
	#print $chisl2."\t".$znam2."\t".$c2."\n";
	
	my $c3 = 1;
	#my $chisl3 = 1;
	#my $znam3 = 1;
	my @chisl3;
	my @znam3;
	foreach my $l(($nnn+1)..$NNN) {
	    #$chisl3 = $chisl3*$l;
	    push (@chisl3,$l);
	}
	foreach my $l(1..($NNN-$nnn)) {
	    push(@znam3,$l);
#$znam3 = $znam3*$l;
	}
	if ($#chisl2 != $#znam2) {
	    print "!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
	}
	#$c3 = $chisl3/$znam3;
	foreach my $number(0..$#chisl3) {
	    my $ch = $chisl3[$number];
	    my $zn = $znam3[$number];
	    my $ratio = $ch/$zn;
	    $c3 = $c3*$ratio;
	}
	#print $c1."\t".$c2."\t".$c3."\n";
	
	my $ppp = $c1*$c2/$c3;
	if ($k == $kkk) {
	    $p_actual = $ppp;
	}
	$p_over += $ppp;
		#print $ppp."\t".$p_over."\n";
	#die;
    }
    my $p_under = 1 - $p_over+$p_actual;
    #  my $year_ker = $cell_year_ker{$zone};
	  #  $year_ker =~ m/\_/;
	  #  my $year = $`;
	  #  my $ker = "$'";
	    
    print OUT $fam."\t".$NNN."\t".$KKK."\t".$nnn."\t".$kkk."\t".$p_over."\t".$p_under."\n";
}


