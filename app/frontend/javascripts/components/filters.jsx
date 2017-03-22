'use strict';

import React from 'react';
import {Col, Row, Button, ControlLabel, FormControl} from 'react-bootstrap'
import ReactSelect from 'react-select';
import 'react-select/dist/react-select.css';

const Filters = React.createClass({
    propTypes: {
        page: React.PropTypes.number,
        breed_id: React.PropTypes.number,
        castrated: React.PropTypes.number,
        name: React.PropTypes.string,
        last_visit_since: React.PropTypes.string,
        last_visit_until: React.PropTypes.string,
        owner_name: React.PropTypes.string,
        birth_date: React.PropTypes.string
    },

    getInitialState() {
        return {
            page: 1,
            breed_id: this.props.params.breed_id || null,
            castrated: this.props.params.castrated || null,
            gender_cd: this.props.params.gender_cd || null,
            name: this.props.params.name || null,
            last_visit_since: this.props.params.last_visit_since || null,
            last_visit_until: this.props.params.last_visit_until || null,
            owner_name: this.props.params.owner_name || null,
            birth_date: this.props.params.birth_date || null
        };
    },

    cleanSearch() {
        window.location = this.props.path
    },

    getBreedValue(val) {
        this.setState({breed_id: val});
    },

    getCastrateValue(val) {
        this.setState({castrated: val});
    },

    getGenderValue(val) {
        this.setState({gender_cd: val});
    },

    render() {
        let castrate_options = [
            {value: '1', label: 'Sim'},
            {value: '0', label: 'Não'}
        ];

        let gender_options = [
            {value: '1', label: 'Fêmea'},
            {value: '2', label: 'Macho'}
        ];

        let { token, path } = this.props;

        return (
            <form acceptCharset="UTF-8" action={path} method="GET">
                <input name="authenticity_token" type="hidden" value={token}/>
                <input name="utf8" type="hidden" value="✓"/>
                <Row>
                    <Col md={4}>
                        <Input name="name" label="Nome do Cachorro" value={this.state.name}/>
                        <Select name="breed_id"
                                label="Raça"
                                callback={this.getBreedValue}
                                options={this.props.breeds}
                                value={this.state.breed_id}
                        />
                        <Input name="last_visit_since" label="Última visita desde" type="date" value={this.state.last_visit_since}/>
                    </Col>

                    <Col md={4}>
                        <Input name="owner_name" label="Nome do Dono" value={this.state.owner_name}/>
                        <Select name="castrated"
                                label="Castrado?"
                                callback={this.getCastrateValue}
                                options={castrate_options}
                                value={this.state.castrated}
                        />
                        <Input name="last_visit_until" label="Última visita até" type="date" value={this.state.last_visit_until}/>
                    </Col>

                    <Col md={4}>
                        <Select
                            name="gender_cd"
                            label="Genero"
                            callback={this.getGenderValue}
                            options={gender_options}
                            value={this.state.gender_cd}
                        />
                        <Input name="birth_date" label="Data de Nascimento" type="date" value={this.state.birth_date}/>
                        <Button onClick={this.cleanSearch} style={{marginTop: 30}}>Limpar Pesquisa</Button>
                        <Button type="submit" className="pull-right" style={{marginTop: 30}} bsStyle="success">Filtrar</Button>
                    </Col>
                </Row>
            </form>
        );
    }
});

function Input({label, name, type = 'text', value}) {
    return (
        <div style={{marginTop: 4}}>
            <ControlLabel>{label}</ControlLabel>
            <FormControl type={type} name={name} defaultValue={value}/>
        </div>
    );
}

function Select({label, options, value, callback, name}) {
    console.log(value);
    return (
        <div style={{marginTop: 4}}>
            <ControlLabel>{label}</ControlLabel>
            <ReactSelect
                name={name}
                value={value}
                options={options}
                onChange={callback}
            />
        </div>
    );
}


export default Filters