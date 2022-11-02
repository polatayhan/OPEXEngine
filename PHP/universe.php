<?php
Class Universe {
    protected array $galaxies = ['milkyWay', 'andromeda', 'VIRGO', 'Milkyway'];
    protected array $stars = ['polaris', 'sirius'];
}

Class Galaxy extends Universe {
    public function get_all(bool $formatted = FALSE): array
    {
        // TASK: This method should return raw or formatted unique $galaxies
        // Check $formatted argument's value and if it's value TRUE ...
        if($formatted) {
            foreach($this->galaxies as &$value) {
                // Format value via format_name method.
               $value = $this->format_name($value);
            }
            // Convert unique array using native php function 'array_unique'
            return array_unique($this->galaxies);
        }
        // if $formatted argument's value FALSE ...
        return $this->galaxies;
    }
    
    protected function format_name(string $name): string
    {
        // TASK: This method should return properly capitalized name. For example, CucumBER would be retuned as Cucumber
        // First step: strtolower() function. Convert all letters to lowercase
        // Second step: ucfirst() function. Convert first letter to uppercase
        return ucfirst(strtolower($name));
    }
}

Class Stars extends Galaxy {
    private function get_stars(): array
    {
        // TASK: This method should return raw $stars
        return $this->stars;
    }
    
    public function add_stars(array &$stars): void
    {
        /*
            TASK: This method does not return anything; however,
            it should append some values to $stars and ensure there are no duplicates and
            that $stars are properly capitalized
        */

        // We can add unique values two ways:

        //FIRST WAY:
        foreach(array_reverse($this->stars) as &$value) {
            if(!in_array($value, $stars)) {
                array_unshift($stars, $value);
            }
        }

        // SECOND WAY: (Comment line 53 - 57 and Uncomment line 60)
        //$stars = array_unique(array_merge($this->stars, $stars));

        // Format Each Element
        array_walk($stars, function(&$val){ $val = $this->format_name($val); });
    }
}

$galaxy = new Galaxy;
print_r ($galaxy->get_all());
print_r ($galaxy->get_all(TRUE));

$my_stars = ['rigel', 'canopus'];
$stars = new Stars;
$stars->add_stars($my_stars);
print_r($my_stars);