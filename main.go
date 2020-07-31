package main

import (
	"fmt"
	"os"

	"github.com/kelseyhightower/envconfig"
	"github.com/namsral/flag"
	"gopkg.in/yaml.v2"
)

type Config = struct {
	Admin struct {
		User string `yaml:"user" envconfig:"ADMIN_USER"`
		Pass string `yaml:"pass" envconfig:"ADMIN_PASS"`
	} `yaml:"admin"`

	Redis struct {
		Port int16 `yaml:"port" envconfig:"REDIS_PORT"`
	} `yaml:"redis"`

	Postgres struct {
		Host   string `yaml:"host" envconfig:"POSTGRES_HOST"`
		Port   int16  `yaml:"port" envconfig:"POSTGRES_PORT"`
		User   string `yaml:"user" envconfig:"POSTGRES_USER"`
		Pass   string `yaml:"pass" envconfig:"POSTGRES_PORT"`
		DBName string `yaml:"dbname" envconfig:"POSTGRES_DBNAME"`
	} `yaml:"postgres"`
}

func main() {
	var cfg Config
	readFile(&cfg)
	readEnv(&cfg)
	fmt.Println(fmt.Sprintf("%+v", cfg))
	fmt.Println(fmt.Sprintf("Postgres: postgresql://%s:%s@%s:%v/%s", cfg.Postgres.User, cfg.Postgres.Pass, cfg.Postgres.Host, cfg.Postgres.Port, cfg.Postgres.DBName))
	fmt.Println(fmt.Sprintf("Postgres : %+v", cfg.Postgres.Host))
}

func processError(err error) {
	fmt.Println(err)
	os.Exit(2)
}

func readFile(cfg *Config) {
	var env = "dev"
	flag.StringVar(&env, "env", env, "Environment: dev, tst, prd")
	flag.Parse()
	fmt.Println(fmt.Sprintf("env: %s", env))
	f, err := os.Open(fmt.Sprintf("configs/%s.yaml", env))
	if err != nil {
		processError(err)
	}
	defer f.Close()

	decoder := yaml.NewDecoder(f)
	err = decoder.Decode(cfg)
	if err != nil {
		processError(err)
	}
}

func readEnv(cfg *Config) {
	err := envconfig.Process("", cfg)
	if err != nil {
		processError(err)
	}
}
