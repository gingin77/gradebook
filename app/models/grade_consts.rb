module GradeConsts
  PRCT_TO_LTR = {
    93..(1/0.0) => 'A',
    90..93 => 'A-',
    87..90 => 'B+',
    83..87 => 'B',
    80..83 => 'B-',
    77..80 => 'C+',
    73..77 => 'C',
    70..73 => 'C-',
    60..70 => 'D',
    0..60 => 'F'
  }

  LTR_TO_GRD_PTS = {
    'A' => 4.0,
    'A-' => 3.7,
    'B+' => 3.3,
    'B' => 3.0,
    'B-' => 2.7,
    'C+' => 2.3,
    'C' => 2.0,
    'C-' => 1.7,
    'D' => 1.0,
    'F'=> 0
  }
end