package Image::GD::Thumbnail;

use 5.006;
use strict;
use warnings;
our $VERSION = '0.01';

=head1 NAME

Image::GD::Thumbnail - create thumbnail images with GD

=head1 SYNOPSIS

  use GD;
  use Image::GD::Thumbnail;

  # Load your source image
  open IN, 'E:/Images/test.jpg'  or die "Could not open.";
  my $srcImage = GD::Image->newFromJpeg(*IN);
  close IN;

  # Create the thumbnail from it, where the biggest side is 50 px
  my $thumb = create($srcImage,50);

  # Save your thumbnail
  open OUT, ">E:/Images/thumb_test.jpg" or die "Could not save ";
  binmode OUT;
  print OUT $thumb->jpeg;
  close OUT;

  __END__

=head1 DESCRIPTION

This module uses the GD library to create a thumbnail image with no side bigger than you specify.

The subroutine C<create> takes two arguments: the first is a GD image object, the second is the size, in pixels, you wish the image's longest side to be.

=head1 PREREQUISITES

	GD

=cut

sub create { my ($orig,$n) = (shift,shift);
	my ($ox,$oy) = $orig->getBounds();
	my $r = $ox>$oy ? $ox / $n : $oy / $n;
	my $thumb = new GD::Image($ox/$r,$oy/$r);
	$thumb->copyResized($orig,0,0,0,0,$ox/$r,$oy/$r,$ox,$oy);
	return $thumb;
}

1;

__END__

=head2 EXPORT

None by default.

=head1 AUTHOR

Lee Goddard <LGoddard@CPAN.org>

=head1 SEE ALSO

L<perl>, L<GD>.

=cut

