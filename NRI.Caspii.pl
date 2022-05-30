use strict;
use Bio::TreeIO;

my @trees = ("Caspii12.Tree1.newick","Caspii12.Tree2.newick","Caspii12.Tree3.newick");
foreach my $tree1(@trees) {
    my $in = Bio::TreeIO -> new(-file => $tree1,
				-format => 'newick');
    
    my $tree = $in -> next_tree;
###MarkedTree.newick was created by naming unnamed nodes in 'Appendix_S3.newick';
    
#my $tree_file = 'Appendix_S3.newick';
#open (TR, $tree_file) or die $!;
#my $tr = <TR>;
    
#my $bl = $tree -> total_branch_length;
    my @leafnodes = $tree->get_leaf_nodes;
#print $bl."\t".$#leafnodes."\n";
    my @tree_species;
    foreach my $leafnode(@leafnodes)  {
	my $leaf = $leafnode->id;
	#$leaf =~ s /\.//;
	push(@tree_species,$leaf);
    }


    open (IN, "Caspii.sp_gen_fam_C1C2.NEW.txt") or die $!;
#my %gen_fam;
    my %zone_sp;
#my @geni;

#open (STR,">>Strange_geni") or die $!;
#my $names = <IN>;
while (<IN>) {
    my $str= $_;
    my @all = $str =~ m/\w+/g;
    my $species = $all[0];
    my $genus = $all[1];
    my $biotop = $all[3];

    if ($species ~~ @tree_species) {
	#if ($biotop eq "lost" | $biotop eq "acquired") {
	 #   push(@{$zone_sp{$biotop}},$species);
	#}
	if ($biotop eq "C1C2") {
        }
	elsif ($biotop eq "C2") {
	    push(@{$zone_sp{"lost"}},$species);
	}
	elsif ($biotop eq "C1") {
            push(@{$zone_sp{"aqcuired"}},$species);
        }
    }
    else {
	print $species."\n";
    }
}

###make null distribution of ratios
my @exp_ratios;
my $n = 0;
until($n == 1000) {
    $n ++;
    my $new_conv_chisl = 0;
    my $new_conv_znam = 0;
    until ($new_conv_znam == 100) {
	my $rand1 = int(rand($#tree_species+1));
	my $rand2 = int(rand($#tree_species+1));
	my $id1 = $tree_species[$rand1];
	my $id2 = $tree_species[$rand2];

	my $node1 = $tree->find_node(-id=>$id1);
	#print $id1."\t".$id2."\n";
	my $node2 = $tree->find_node(-id=>$id2);
	my $dist = $tree->distance(-nodes=>[$node1,$node2]);		    
	
	$new_conv_chisl += $dist;
	$new_conv_znam += 1;
    }
    my $new_conv_dist = $new_conv_chisl/$new_conv_znam;
    push(@exp_ratios,$new_conv_dist);
}
my @sort_exp = sort {$b <=> $a} @exp_ratios;
my $mean_exp = &average(\@sort_exp);
my $std_exp = &stdev(\@sort_exp);

foreach my $zone(keys %zone_sp) {
    my @sp = @{$zone_sp{$zone}};
    my $cnk = ($#sp*($#sp+1))/2;
    #print $me."\t".$#me_gen."\n";
    if ($cnk > 100) {
	my $conv_chisl = 0;
	my $conv_znam = 0;
	open (OUT,">>".$tree1."_".$zone.".1000repeats.PhylSignal_100Pairs_vs_RandPairs.txt") or die $!;
	open (NULL, ">>".$tree1."_".$zone."H0.txt") or die $!;

	  until ($conv_znam == 100) {
	    my $rand1 = int(rand($#sp+1));
	    my $rand2 = int(rand($#sp+1));
	    my $id1 = $sp[$rand1];
	    my $id2 = $sp[$rand2];
	    
	    my $node1 = $tree->find_node(-id=>$id1);
	    my $node2 = $tree->find_node(-id=>$id2);
	   # print $zone."\t".$id1."\t".$id2."\n";
	    my $dist = $tree->distance(-nodes=>[$node1,$node2]);
	  
	    
	    $conv_chisl += $dist;
	    $conv_znam += 1;
	  }
	
	my $distance = $conv_chisl/$conv_znam;
	
	my $p_val = 0.001;
	my $exp_n_pv;
	my $z_score = ($distance-$mean_exp)/$std_exp;

	foreach my $exp_n(0..$#sort_exp) {
	    my $exp_distance = $sort_exp[$exp_n];
	    if ($distance >= $exp_distance) {
		$exp_n_pv = $#sort_exp-$exp_n+1;
		$p_val = $exp_n_pv/($#sort_exp+1);
		last;
	    }
	}
	foreach my $exp_n(0..$#sort_exp) {
	    my $exp_distance = $sort_exp[$exp_n];
	    print NULL $exp_distance."\n";
	}

	my $sp_number = $#sp+1;
	print OUT $zone."\t".$sp_number."\t".$distance."\t".$p_val."\t".$z_score."\n";
	  
    }
    
    elsif ($#sp > 0 && $cnk <= 100) {
	my $conv_chisl = 0;
	my $conv_znam = 0;
	open (OUT,">>".$tree1."_".$zone.".1000repeats.PhylSignal_AllPairs_vs_RandPairs.txt") or die$!;
        open (NULL, ">>".$tree1."_".$zone."H0.txt") or die $!;

	foreach my $sp_n1(0..($#sp-1)) {
	    my $id1 = $sp[$sp_n1];
	    foreach my $sp_n2(($sp_n1+1)..$#sp) {
		my $id2 = $sp[$sp_n2];
		
		#my $id1 = $genus_id{$gen1};
		#my $id2 = $genus_id{$gen2};
		
		my $node1 = $tree->find_node(-id=>$id1);
		my $node2 = $tree->find_node(-id=>$id2);
		my $dist = $tree->distance(-nodes=>[$node1,$node2]);
		
		$conv_chisl += $dist;
		$conv_znam += 1;
	    }
	}
	
	my $distance = $conv_chisl/$conv_znam;
	
	my @indiv_exp_ratios;
        my $n = 0;
        until($n == 1000) {
            $n ++;
            my @new_me;
            my @used;
            until($#used == $#sp) {
                my $rand=int(rand($#tree_species+1));
                if ($rand ~~ @used) {
                }
                else {
                    my $genus = $tree_species[$rand];
                    push(@used,$rand);
                    push(@new_me,$genus);
                }
            }
	    
	    my $new_conv_chisl = 0;
            my $new_conv_znam = 0;
            foreach my $gen_n1(0..($#new_me-1)) {
                my $id1 = $new_me[$gen_n1];
                foreach my $gen_n2(($gen_n1+1)..$#new_me) {
                    my $id2 = $new_me[$gen_n2];
                    my $node1 = $tree->find_node(-id=>$id1);
                    my $node2 = $tree->find_node(-id=>$id2);
                    my $dist = $tree->distance(-nodes=>[$node1,$node2]);
		    
                    $new_conv_chisl += $dist;
                    $new_conv_znam += 1;
                }
            }
            my $new_conv_dist = $new_conv_chisl/$new_conv_znam;
	    push(@indiv_exp_ratios,$new_conv_dist);
	    print NULL $new_conv_dist."\n";
	}
	
	my $p_val = 0.001;
	my $exp_n_pv;
	my @sort_indiv_exp = sort {$b <=> $a} @indiv_exp_ratios;
	my $mean_indiv_exp = &average(\@sort_indiv_exp);
	my $std_indiv_exp = &stdev(\@sort_indiv_exp);
	my $z_score = ($distance-$mean_indiv_exp)/$std_indiv_exp;
	
	foreach my $exp_n(0..$#sort_indiv_exp) {
	    my $exp_distance = $sort_indiv_exp[$exp_n];
	    if ($distance >= $exp_distance) {
		$exp_n_pv = $#sort_indiv_exp-$exp_n+1;
		$p_val = $exp_n_pv/($#sort_indiv_exp+1);
		last;
	    }
	}
	my $sp_number = $#sp+1;
	print OUT $zone."\t".$sp_number."\t".$distance."\t".$p_val."\t".$z_score."\n";
	
    }
}
}


sub average{
    my($data) = @_;
    if (not @$data) {
        die("Empty arrayn");
    }
    my $total = 0;
    foreach (@$data) {
        $total += $_;
    }
    my $average = $total / @$data;
    return $average;
}
sub stdev{
    my($data) = @_;
    if(@$data == 1){
        return 0;
    }
    my $average = &average($data);
    my $sqtotal = 0;
    foreach(@$data) {
        $sqtotal += ($average-$_) ** 2;
    }
    my $std = ($sqtotal / (@$data-1)) ** 0.5;
    return $std;
}


    
 
