#!/usr/bin/php
<?php

$dir = new GlobIterator('*.tmx');
foreach ($dir as $file) {
  $file = ltrim($file, '/');
  $map = '<map>';
  $xml = simplexml_load_file($file);

  foreach ($xml->layer as $layer) {
    $data = preg_replace("/,\n/", "\n", trim($layer->data));
    $data = explode("\n", $data);
    $map .= '<layer name="'.$layer['name'].'">';

    foreach ($data as $i => $line) {
      $line = explode(',', $line);
      $line = array_map(function ($tile) {
        return '0' == $tile ? 0 : $tile - 1;
      }, $line);
      $data[$i] = implode(',', $line);
    }

    $map .= implode("\n", $data);
    $map .= '</layer>';
  }

  $map .= '</map>';
  file_put_contents(str_replace('.tmx', '.xml', $file), $map);
}
